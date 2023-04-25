import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  TextEditingController abc = TextEditingController();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Bar"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: abc,
              decoration: const InputDecoration(
                  hintText: 'search', suffixIcon: Icon(Icons.search)),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  final String position = index.toString();
                  if (abc.text.isEmpty) {
                    return ListTile(
                      title: Text("Sohail  $index"),
                      subtitle: const Text("How are you Sohail?"),
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage("images/abc.png"),
                      ),
                    );
                  } else if (position
                      .toLowerCase()
                      .contains(abc.text.toString())) {
                    return ListTile(
                      title: Text("Sohail  $index"),
                      subtitle: const Text("How are you Sohail?"),
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage("images/abc.png"),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
