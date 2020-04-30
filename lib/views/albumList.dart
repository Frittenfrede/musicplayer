import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musikarkiv/notifiers/album_notifier.dart';
import 'package:provider/provider.dart';

class AlbumList extends StatefulWidget {
  AlbumList({Key key}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    AlbumNotifier albumNotifier = Provider.of<AlbumNotifier>(context);

    //Regex pattern for finding URL's
    var urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Albums"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Center(
              child: ListView.builder(
                itemCount: albumNotifier.albumList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    return Navigator.pushNamed(context, "trackList",
                        arguments: albumNotifier.albumList[index]);
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //Contains an image which can now be edited
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              // Checks whether the string "cover" is an url or filepath
                              child: RegExp(urlPattern, caseSensitive: false)
                                      .hasMatch(
                                          albumNotifier.albumList[index].cover)
                                  ? Image(
                                      image: NetworkImage(
                                          albumNotifier.albumList[index].cover),
                                      height: 100,
                                      width: 100,
                                    )
                                  //Shows image from the phones photoalbum
                                  : Image.file(
                                      File(
                                          albumNotifier.albumList[index].cover),
                                      height: 100,
                                      width: 100,
                                    )),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  albumNotifier.albumList[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(albumNotifier.albumList[index].artist),
                                Text(albumNotifier.albumList[index].genre),
                                Text(albumNotifier.albumList[index].releaseYear
                                    .toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      new Divider(
                        height: 10.0,
                      )
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            return Navigator.pushNamed(context, "addAlbum");
          },
          label: Text('Add Album'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
