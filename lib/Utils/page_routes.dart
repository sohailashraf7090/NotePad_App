import 'package:flutter/material.dart';
import 'package:local_database/Utils/routes_name.dart';
import 'package:local_database/home_screen.dart';
import 'package:local_database/screen/read_notes.dart';
import 'package:local_database/screen/splashscree.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.readNote:
        return MaterialPageRoute(builder: (context) => const ReadNotes());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
         case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Text("Error"),
          );
        });
    }
  }
}
