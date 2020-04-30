import 'package:flutter/material.dart';
import 'package:musikarkiv/notifiers/album_notifier.dart';
import 'package:provider/provider.dart';
import 'router.dart' as router;

void main() => runApp(ChangeNotifierProvider(
    create: (context) => AlbumNotifier(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'music archive app',
      onGenerateRoute: router.generateRoute,
      initialRoute: "/",
    );
  }
}
