import 'package:flutter/material.dart';
import 'package:musikarkiv/views/addAlbum.dart';
import 'package:musikarkiv/views/addTrack.dart';
import 'package:musikarkiv/views/albumList.dart';
import 'package:musikarkiv/views/trackInfo.dart';
import 'package:musikarkiv/views/trackList.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => AlbumList());
    case 'trackList':
      var album = settings.arguments;
      return MaterialPageRoute(builder: (context) => TrackList(album: album));

    case 'addTrack':
      var arguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => Addtrack(tracks: arguments));

    case 'trackInfo':
      List<Object> track = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => TrackInfo(track: track[0], album: track[1]));

      break;
    case 'addAlbum':
      return MaterialPageRoute(builder: (context) => AddAlbum());
    default:
      return MaterialPageRoute(builder: (context) => AlbumList());
  }
}
