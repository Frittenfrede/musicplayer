import 'package:flutter/material.dart';
import 'package:musikarkiv/model/Album.dart';

class TrackList extends StatefulWidget {
  final Album album;
  TrackList({Key key, this.album}) : super(key: key);

  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.title),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          child: Center(
            child: ListView.builder(
              itemCount: widget.album.tracks.length,
              itemBuilder: (context, index) => Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "trackInfo",
                        arguments: [widget.album.tracks[index], widget.album]);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.album.tracks[index].getNumber.toString() +
                            "."),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                            child: Text(
                                widget.album.tracks[index].getTitle.toString(),
                                style: widget.album.tracks[index].getFavorite
                                    ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.yellow)
                                    : TextStyle(color: Colors.black))),
                        widget.album.tracks[index].getFavorite
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : Text("     ")
                      ]),
                ),
                new Divider(
                  height: 10.0,
                ) //
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
