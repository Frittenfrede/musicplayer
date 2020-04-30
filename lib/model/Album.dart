import 'package:musikarkiv/model/Track.dart';

class Album {
  String _title;
  String _artist;
  int _releaseYear;
  String _genre;
  String _cover;
  List<Track> _tracks;

  Album(this._title, this._artist, this._releaseYear, this._genre, this._cover,
      this._tracks);

  String get title => _title;
  String get artist => _artist;
  int get releaseYear => _releaseYear;
  String get genre => _genre;
  String get cover => _cover;
  List<Track> get tracks => _tracks;

  addTrack(Track track) {
    _tracks.add(track);
  }
}
