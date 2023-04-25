import 'package:hive/hive.dart';
import 'package:local_database/models/note_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>("newfile");
}