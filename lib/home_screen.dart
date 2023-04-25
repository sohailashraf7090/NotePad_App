// ignore_for_file: arintvoid_p

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:local_database/models/note_model.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:local_database/screen/new.notes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'Utils/routes_name.dart';
import 'box/box_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: AnimatedSearchBar(
              label: "Notes",
              controller: searchcontroller,
              labelStyle: const TextStyle(fontSize: 22),
              searchStyle: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              searchDecoration: const InputDecoration(
                hintText: "Search",
                alignLabelWithHint: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.blue.shade500,
                    highlightColor: Colors.blue.shade200,
                    child: Container(
                      width: double.infinity,
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.shade500),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lock,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Tap to card read the Note",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<Box<NotesModel>>(
                valueListenable: Boxes.getData().listenable(),
                builder: (context, box, _) {
                  var data = box.values.toList().cast<NotesModel>();
                  return Expanded(
                    child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final String position = data[index].title.toString();
                          if (searchcontroller.text.isEmpty) {
                            return InkWell(
                              onTap: () async {
                                print("tap");

                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                sp.setString(
                                    'title', data[index].title.toString());
                                sp.setString('discription',
                                    data[index].discription.toString());
                                print("tap2");
                                Navigator.pushNamed(
                                    context, RouteName.readNote);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].date.toString()),
                                      Row(
                                        children: [
                                          Text(data[index].title.toString()),
                                          const Spacer(),
                                          PopupMenuButton(
                                              onSelected: (selected) {
                                            if (selected == 1) {
                                              return editDialog(
                                                  data[index],
                                                  data[index].title.toString(),
                                                  data[index]
                                                      .discription
                                                      .toString());
                                            } else if (selected == 2) {
                                              return delete(data[index]);
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          }, itemBuilder: (context) {
                                            return [
                                              const PopupMenuItem(
                                                  value: 1,
                                                  child: Text("Edit")),
                                              PopupMenuItem(
                                                value: 2,
                                                child: const Text("Delete"),
                                                onTap: () {},
                                              )
                                            ];
                                          })
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (position
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase())) {
                            return InkWell(
                              onTap: () async {
                                print("tap");

                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                sp.setString(
                                    'title', data[index].title.toString());
                                sp.setString('discription',
                                    data[index].discription.toString());
                                print("tap2");
                                Navigator.pushNamed(
                                    context, RouteName.readNote);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              color: Colors.amber,
                                              child: Text(data[index]
                                                  .title
                                                  .toString())),
                                          const Spacer(),
                                          PopupMenuButton(
                                              onSelected: (selected) {
                                            if (selected == 1) {
                                              return editDialog(
                                                  data[index],
                                                  data[index].title.toString(),
                                                  data[index]
                                                      .discription
                                                      .toString());
                                            } else if (selected == 2) {
                                              return delete(data[index]);
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          }, itemBuilder: (context) {
                                            return [
                                              const PopupMenuItem(
                                                  value: 1,
                                                  child: Text("Edit")),
                                              PopupMenuItem(
                                                value: 2,
                                                child: const Text("Delete"),
                                                onTap: () {},
                                              )
                                            ];
                                          })
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("add");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WriteNotes()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void delete(NotesModel notesModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Are You Sure?"),
            actions: [
              TextButton(
                  onPressed: () {
                    notesModel.delete();
                    Navigator.pop(context);
                    AnimatedSnackBar.material(
                      'Deleted Succesfully',
                      duration: const Duration(seconds: 1),
                      type: AnimatedSnackBarType.info,
                      desktopSnackBarPosition:
                          DesktopSnackBarPosition.topCenter,
                    ).show(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  void editDialog(NotesModel notesModel, String title1, String discription1) {
    title.text = title1;
    discription.text = discription1;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit-note"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                        labelText: 'title',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: discription,
                    decoration: InputDecoration(
                        labelText: 'Discription',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    notesModel.title = title.text.toString();
                    notesModel.discription = discription.text.toString();
                    notesModel.save();
                    discription.clear();
                    title.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("OK")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

// Another
  Future<void> showDialougeBox() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Note"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: discription,
                    decoration: InputDecoration(
                        labelText: 'Discription',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (title.text.isEmpty && discription.text.isEmpty) {
                      AnimatedSnackBar.material(
                        'Please  Enter Any Text',
                        duration: const Duration(seconds: 1),
                        type: AnimatedSnackBarType.error,
                        desktopSnackBarPosition:
                            DesktopSnackBarPosition.topCenter,
                      ).show(context);
                    } else {
                      final data = NotesModel(
                          title: title.text,
                          discription: discription.text,
                          date:
                              DateFormat("dd-MMM-yyyy").format(DateTime.now()));

                      final box = Boxes.getData();
                      box.add(data);
                      data.save();
                      title.clear();
                      discription.clear();
                      Navigator.pop(context);
                      print(box);
                    }
                  },
                  child: const Text("Add")),
              TextButton(
                  onPressed: () {
                    print("sub");
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }
}
