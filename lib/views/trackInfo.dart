import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musikarkiv/model/Album.dart';
import 'package:musikarkiv/model/Track.dart';

class TrackInfo extends StatefulWidget {
  final Track track;
  final Album album;
  const TrackInfo({Key key, this.track, this.album}) : super(key: key);
  // URL finding regex pattern
  final String urlPattern =
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

  @override
  _TrackInfoState createState() => _TrackInfoState();
}

class _TrackInfoState extends State<TrackInfo> {
  double _progressValue = 0.0;

  //Timer for "mediaplayer"
  Timer t;

  // Shuts the timer down when window is popped
  @override
  void dispose() {
    if (t != null) if (t.isActive) t.cancel();
    super.dispose();
  }

//Keeps tracksof the progressbar
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    t = new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.01;
        print(_progressValue);
        if (_progressValue > 0.98) {
          t.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(children: [
          Expanded(child: Text("    " + widget.track.getTitle)),
          widget.track.getFavorite
              ? Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 25,
                )
              : Text("")
        ]),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(children: [
              Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 18)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  // Checks whether the string "cover" is an url or filepath
                  child: RegExp(widget.urlPattern, caseSensitive: false)
                          .hasMatch(widget.album.cover)
                      ? Image(
                          image: NetworkImage(widget.album.cover),
                          height: 250,
                          width: 250,
                        )
                      : Image.file(
                          File(widget.album.cover),
                          height: 250,
                          width: 250,
                        )),
              Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 18)),
              Row(
                children: <Widget>[
                  Text("0 "),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: LinearProgressIndicator(
                      value: _progressValue,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                  Text(" " + widget.track.getDuration)
                ],
              ),
              Row(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    t.cancel();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    _updateProgress();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    t.cancel();
                    setState(() {
                      _progressValue = 0;
                    });
                  },
                )
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
