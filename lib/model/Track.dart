class Track {
  int _number;
  String _title;
  String _duration;
  bool _favorite;

  Track(this._number, this._title, this._duration, this._favorite);

  int get getNumber => _number;
  String get getTitle => _title;
  String get getDuration => _duration;
  bool get getFavorite => _favorite;

  set number(int number) {
    _number = number;
  }

  set title(String title) {
    _title = title;
  }

  set duration(String duration) {
    _duration = duration;
  }

  set favorite(bool favorite) {
    _favorite = favorite;
  }
}
