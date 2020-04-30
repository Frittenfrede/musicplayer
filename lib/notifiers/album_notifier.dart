import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:musikarkiv/model/Album.dart';
import 'package:musikarkiv/model/Track.dart';

class AlbumNotifier with ChangeNotifier {
  static List<Track> jupiter = [
    Track(1, "Dani California", "4.42", true),
    Track(2, "Snow", "5.35", false),
    Track(3, "Charlie", "4.38", false),
    Track(4, "Stadium Arcadium", "3.33", false),
    Track(5, "Humb De Bump", "5.35", false),
    Track(6, "She's Only 18", "3.25", false),
    Track(7, "Slow Cheetah", "5.20", false),
    Track(8, "Torture Me", "3.45", false),
    Track(9, "Strip My Mind", "4.19", false),
    Track(10, "Especially in Michigan", "4.01", false),
    Track(11, "Warlocks", "3.26", false),
    Track(12, "C'mon Girl", "3.49", false),
    Track(13, "Wet Sand", "5.10", false),
    Track(14, "Hey", "5.40", false),
  ];

  static List<Track> mars = [
    Track(1, "Desecration Smile", "5.02", false),
    Track(2, "Tell Me Baby", "4.08", false),
    Track(3, "Hard To Concentrate", "4.02", false),
    Track(4, "21st Century", "4.22", false),
    Track(5, "She Looks To Me", "4.06", false),
    Track(6, "Readymade", "4.31", false),
    Track(7, "If", "5.25", false),
    Track(8, "Make You Feel Better", "3.52", false),
    Track(9, "Animal Bar", "5.25", true),
    Track(10, "So Much I", "3.45", false),
    Track(11, "Storm in a Teacup", "5.35", false),
    Track(12, "We Believe", "3.36", false),
    Track(13, "Turn It Again", "6.06", false),
    Track(14, "Death of a Martian", "4.25", false),
  ];

  static List<Track> darkSideOfTheMoon = [
    Track(1, "Speak to Me", "1.13", false),
    Track(2, "Breathe", "2.43", false),
    Track(3, "On the Run", "3.36", false),
    Track(4, "Time", "6.53", false),
    Track(5, "The Great Gig in the Sky", "4.36", false),
    Track(6, "Money", "6.23", false),
    Track(7, "Us and Them", "7.49", false),
    Track(8, "Any Colour You Like", "3.26", true),
    Track(9, "Brain Damage", "3.49", false),
    Track(10, "Eclipse", "1.13", false),
  ];

  List<Album> _albums = [
    Album(
        "Jupiter",
        "Red Hot Chili Peppers",
        2006,
        "funk-rock",
        "https://lastfm.freetls.fastly.net/i/u/770x0/f84bb4ed29a541dd8fc844bf0d2cc132.webp#f84bb4ed29a541dd8fc844bf0d2cc132",
        jupiter),
    Album(
        "Mars",
        "Red Hot Chili Peppers",
        2006,
        "funk-rock",
        "https://lastfm.freetls.fastly.net/i/u/500x500/2b479c1778d8499287c9b26ecfe79af0.jpg",
        mars),
    Album(
        "Dark Side of the Moon",
        "Pink Floyd",
        1973,
        "Progressice rock",
        "https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png",
        darkSideOfTheMoon)
  ];

  UnmodifiableListView<Album> get albumList => UnmodifiableListView(_albums);

  addAlbum(Album album) {
    _albums.add(album);
    notifyListeners();
  }
}
