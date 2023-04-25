import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveTest extends StatefulWidget {
  const HiveTest({super.key});

  @override
  State<HiveTest> createState() => _HiveTestState();
}

class _HiveTestState extends State<HiveTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
            future: Hive.openBox("Browser"),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                      title: Text(snapshot.data!.get("name").toString()),
                      subtitle: Text(snapshot.data!.get("age").toString()),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {});
                          print("abcc");
                          snapshot.data!.delete("name");
                          snapshot.data!.delete(
                            "age",
                          );
                        },
                        icon: const Icon(Icons.delete),
                      )),
                ],
              );
            })
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          var box = await Hive.openBox("Browser");
          box.put("name", "Sohail Ashraf");
          box.put("age", "23");
          box.put("Details", {'pro': "Developers", 'int': 'abc'});
          print(box.get("name"));
          print(box.get("age"));
          print(box.get("Details")["int"]);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
