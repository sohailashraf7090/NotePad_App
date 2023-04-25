import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadNotes extends StatefulWidget {
  const ReadNotes({super.key});

  @override
  State<ReadNotes> createState() => _ReadNotesState();
}

class _ReadNotesState extends State<ReadNotes> {
  String title = '';
  String discription = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    title = sp.getString("title") ?? "";
    discription = sp.getString("discription") ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Discription Page")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const Divider(
                height: 30,
                thickness: 2,
              ),
              Text(discription.toString())
            ],
          ),
        ),
      ),
    );
  }
}
