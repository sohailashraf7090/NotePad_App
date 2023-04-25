import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local_database/Utils/page_routes.dart';
import 'package:local_database/home_screen.dart';
import 'package:local_database/models/note_model.dart';
import 'package:path_provider/path_provider.dart';

import 'Utils/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  Hive.openBox<NotesModel>("newfile");

  runApp(const HiveBox());
}

class HiveBox extends StatefulWidget {
  const HiveBox({super.key});
  final String name = "";

  @override
  State<HiveBox> createState() => _HiveBoxState();
}

class _HiveBoxState extends State<HiveBox> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
