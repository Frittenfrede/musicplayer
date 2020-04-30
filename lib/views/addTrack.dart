import 'package:flutter/material.dart';
import 'package:musikarkiv/model/Track.dart';
import 'package:musikarkiv/shared/constants.dart';

class Addtrack extends StatefulWidget {
  final List<Track> tracks;
  const Addtrack({Key key, this.tracks, album}) : super(key: key);

  @override
  _AddtrackState createState() => _AddtrackState();
}

class _AddtrackState extends State<Addtrack> {
  int _number;
  String _title;
  String _duration;
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Track"),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Center(
                  child: Column(children: <Widget>[
                TextFormField(
                  initialValue: _title != null ? _title : "",
                  decoration:
                      textInputDecoration.copyWith(labelText: 'Track title'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a title' : null,
                  onChanged: (val) => _title = val,
                ),
                TextFormField(
                  initialValue: _duration != null ? _duration : "",
                  decoration:
                      textInputDecoration.copyWith(labelText: 'Duration MM:SS'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a duration' : null,
                  onChanged: (val) => _duration = val,
                ),
                TextFormField(
                  initialValue: _number != null ? _number.toString() : "",
                  decoration: textInputDecoration.copyWith(
                      labelText: 'Track number on album'),
                  validator: (val) => val is int || val.isEmpty
                      ? 'Please enter a track number'
                      : null,
                  onChanged: (val) => _number = int.parse(val),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Favorite?"),
                    ),
                    Switch(
                      value: favorite,
                      onChanged: (value) {
                        setState(() {
                          favorite = value;
                        });
                      },
                      activeTrackColor: Colors.redAccent,
                      activeColor: Colors.red,
                    ),
                  ],
                ),
                RaisedButton(
                    color: Colors.red,
                    child: Text('Add Track',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Track newTrack =
                            new Track(_number, _title, _duration, favorite);
                        widget.tracks.add(newTrack);

                        Navigator.pop(context, widget.tracks);
                      }
                    })
              ])),
            ),
          ),
        ));
  }
}
