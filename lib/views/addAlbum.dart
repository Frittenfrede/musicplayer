import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musikarkiv/model/Album.dart';
import 'package:musikarkiv/model/Track.dart';
import 'package:musikarkiv/notifiers/album_notifier.dart';
import 'package:musikarkiv/shared/constants.dart';
import 'package:provider/provider.dart';

class AddAlbum extends StatefulWidget {
  AddAlbum({Key key}) : super(key: key);

  @override
  _AddAlbumState createState() => _AddAlbumState();
}

class _AddAlbumState extends State<AddAlbum> {
  final _formKey = GlobalKey<FormState>();

  String defaultCover =
      "https://www.ovenready.net/promoapp/dist/imgs/default-album-artwork.png";

  //Path to picture in photo library
  String _path;
  String _title;
  String _artist;
  String _genre;
  int _releaseYear;
  List<Track> _tracks = new List<Track>();

  @override
  Widget build(BuildContext context) {
    AlbumNotifier albumNotifier = Provider.of<AlbumNotifier>(context);
    //Shows the photolibrary of the phone
    void _showPhotoLibrary() async {
      final file = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _path = file.path;
      });
    }

    //Alert
    Future<void> _notImplemented() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Not implemented alert!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This feature is not implemented yet.'),
                  Text('Try adding from photo library instead.')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    //ModalBottomSheet for select options
    void _showOptions(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                height: 150,
                child: Column(children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera"),
                    onTap: () {
                      _notImplemented();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"),
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                  )
                ]));
          });
    }

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text("Add Album"),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Container(
                //child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    _path == null
                        ? Image.asset(
                            "images/place-holder.png",
                            height: 150,
                            width: 150,
                          )
                        : Image.file(
                            File(_path),
                            height: 150,
                            width: 150,
                          ),
                    FlatButton(
                      child: Text("Choose Cover",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      onPressed: () {
                        _showOptions(context);
                      },
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Album title'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a title' : null,
                      onChanged: (val) => setState(() => _title = val),
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Artist'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a artist name' : null,
                      onChanged: (val) => setState(() => _artist = val),
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Genre'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _genre = val),
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Release Year'),
                      validator: (val) => val is int || val.isEmpty
                          ? 'Please enter a valid year'
                          : null,
                      onChanged: (val) =>
                          setState(() => _releaseYear = int.tryParse(val)),
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text('Add Album',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Album newAlbum = new Album(
                              _title,
                              _artist,
                              _releaseYear,
                              _genre,
                              _path == null ? defaultCover : _path,
                              _tracks);
                          albumNotifier.addAlbum(newAlbum);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ]),
                ),
                //),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateAndDisplaySelection(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          tooltip: "Add Track",
        ));
  }

//Opens the addtrack view and waits for it to "pop"
  _navigateAndDisplaySelection(BuildContext context) async {
    final result =
        await Navigator.pushNamed(context, "addTrack", arguments: _tracks);
    _tracks = result;
  }
}
