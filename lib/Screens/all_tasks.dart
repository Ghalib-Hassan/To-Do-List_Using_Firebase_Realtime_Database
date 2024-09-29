import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Custom%20Widgets/toast.dart';
import 'package:to_do_list_smit/Utils/colors.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  DatabaseReference db = FirebaseDatabase.instance.ref('TodoList');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  Set<String> selectedItems = {};
  bool isCompleted = false;
  late Query queryDatabase;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryDatabase = FirebaseDatabase.instance
        .ref('TodoList')
        .orderByChild('uid')
        .equalTo(auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search by title', border: OutlineInputBorder()),
            onChanged: (v) {
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
              // reverse: true,
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              query: queryDatabase,
              itemBuilder: (context, snapshot, _, index) {
                if (snapshot
                    .child('Title')
                    .value
                    .toString()
                    .toLowerCase()
                    .contains(searchController.text.toString())) {
                  int colorIndex = index % colors.length;

                  return GestureDetector(
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colors[colorIndex],
                        ),
                        child: Center(
                          child: Text(
                            snapshot
                                .child('Title')
                                .value
                                .toString()
                                .substring(0, 1)
                                .toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: colors[colorIndex] == Colors.black
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: colors[colorIndex] == Colors.black
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.child('Title').value.toString(),
                        style: GoogleFonts.ubuntuMono(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        snapshot.child('Description').value.toString(),
                        style: GoogleFonts.ubuntuMono(fontSize: 17),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                String taskId =
                                    snapshot.child('id').value?.toString() ??
                                        '';
                                bool isCompleted = (snapshot
                                        .child('completed')
                                        .value as bool?) ??
                                    false;

                                if (isCompleted) {
                                  db.child(taskId).update({
                                    'completed': false,
                                  }).then((v) {
                                    selectedItems.remove(taskId);
                                    ToastPopUp().toast('Not completed',
                                        Colors.blue, Colors.white);
                                  }).catchError((error) {
                                    ToastPopUp().toast(error.toString(),
                                        Colors.red, Colors.white);
                                  });
                                } else {
                                  db.child(taskId).update({
                                    'completed': true,
                                  }).then((v) {
                                    selectedItems.add(taskId);
                                    ToastPopUp().toast(
                                        'Completed', Colors.blue, Colors.white);
                                  }).catchError((error) {
                                    ToastPopUp().toast(error.toString(),
                                        Colors.red, Colors.white);
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: (snapshot.child('completed').value
                                            as bool?) ??
                                        false
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Icon(Icons.check,
                                    color: (snapshot.child('completed').value
                                                as bool?) ??
                                            false
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (String value) {
                              if (snapshot.child('Title').value == null ||
                                  snapshot.child('Description').value == null ||
                                  snapshot.child('id').value == null) {
                                ToastPopUp().toast('Some data is missing',
                                    Colors.red, Colors.white);
                                return;
                              }

                              titleController.text =
                                  snapshot.child('Title').value.toString();
                              descriptionController.text = snapshot
                                  .child('Description')
                                  .value
                                  .toString();
                              String id = snapshot.child('id').value.toString();

                              if (value == 'Edit') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: TextField(
                                        maxLines: 1,
                                        controller: titleController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder()),
                                      ),
                                      content: TextField(
                                        maxLines: 5,
                                        controller: descriptionController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder()),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            if (titleController.text
                                                    .trim()
                                                    .isEmpty ||
                                                descriptionController.text
                                                    .trim()
                                                    .isEmpty) {
                                              ToastPopUp().toast(
                                                  'Please fill all the fields',
                                                  Colors.red,
                                                  Colors.white);
                                              return;
                                            } else {
                                              db.child(id).update({
                                                'Title': titleController.text,
                                                'Description':
                                                    descriptionController.text
                                              }).then((v) {
                                                ToastPopUp().toast(
                                                    'Data updated successfully',
                                                    Colors.green,
                                                    Colors.white);
                                              }).onError((error, v) {
                                                ToastPopUp().toast(
                                                    error.toString(),
                                                    Colors.red,
                                                    Colors.white);
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text('Save',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (value == 'Delete') {
                                db
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove()
                                    .then((v) {
                                  ToastPopUp().toast(
                                      'Data deleted successfully',
                                      Colors.green,
                                      Colors.white);
                                }).onError((error, v) {
                                  ToastPopUp().toast(error.toString(),
                                      Colors.red, Colors.white);
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                    value: 'Edit', child: Text('Edit')),
                                const PopupMenuItem<String>(
                                    value: 'Delete', child: Text('Delete')),
                              ];
                            },
                            icon: const Icon(Icons.more_vert),
                            offset: const Offset(0, 50),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.child('Title').value == null ||
                    snapshot.child('Description').value == null) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    child: Center(
                      child: Text(
                        'No Tasks Found',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ),
                  );
                } else if (searchController.text.isEmpty) {
                  int colorIndex = index % colors.length;

                  return GestureDetector(
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colors[colorIndex],
                        ),
                        child: Center(
                          child: Text(
                            snapshot
                                .child('Title')
                                .value
                                .toString()
                                .substring(0, 1)
                                .toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: colors[colorIndex] == Colors.black
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: colors[colorIndex] == Colors.black
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.child('Title').value.toString(),
                        style: GoogleFonts.ubuntuMono(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        snapshot.child('Description').value.toString(),
                        style: GoogleFonts.ubuntuMono(fontSize: 17),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                String taskId =
                                    snapshot.child('id').value?.toString() ??
                                        '';
                                bool isCompleted = (snapshot
                                        .child('completed')
                                        .value as bool?) ??
                                    false;

                                if (isCompleted) {
                                  db.child(taskId).update({
                                    'completed': false,
                                  }).then((v) {
                                    selectedItems.remove(taskId);
                                    ToastPopUp().toast('Not completed',
                                        Colors.blue, Colors.white);
                                  }).catchError((error) {
                                    ToastPopUp().toast(error.toString(),
                                        Colors.red, Colors.white);
                                  });
                                } else {
                                  db.child(taskId).update({
                                    'completed': true,
                                  }).then((v) {
                                    selectedItems.add(taskId);
                                    ToastPopUp().toast(
                                        'Completed', Colors.blue, Colors.white);
                                  }).catchError((error) {
                                    ToastPopUp().toast(error.toString(),
                                        Colors.red, Colors.white);
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: (snapshot.child('completed').value
                                            as bool?) ??
                                        false
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Icon(Icons.check,
                                    color: (snapshot.child('completed').value
                                                as bool?) ??
                                            false
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (String value) {
                              if (snapshot.child('Title').value == null ||
                                  snapshot.child('Description').value == null ||
                                  snapshot.child('id').value == null) {
                                ToastPopUp().toast('Some data is missing',
                                    Colors.red, Colors.white);
                                return;
                              }

                              titleController.text =
                                  snapshot.child('Title').value.toString();
                              descriptionController.text = snapshot
                                  .child('Description')
                                  .value
                                  .toString();
                              String id = snapshot.child('id').value.toString();

                              if (value == 'Edit') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: TextField(
                                        maxLines: 1,
                                        controller: titleController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder()),
                                      ),
                                      content: TextField(
                                        maxLines: 5,
                                        controller: descriptionController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder()),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            if (titleController.text
                                                    .trim()
                                                    .isEmpty ||
                                                descriptionController.text
                                                    .trim()
                                                    .isEmpty) {
                                              ToastPopUp().toast(
                                                  'Please fill all the fields',
                                                  Colors.red,
                                                  Colors.white);
                                              return;
                                            } else {
                                              db.child(id).update({
                                                'Title': titleController.text,
                                                'Description':
                                                    descriptionController.text
                                              }).then((v) {
                                                ToastPopUp().toast(
                                                    'Data updated successfully',
                                                    Colors.green,
                                                    Colors.white);
                                              }).onError((error, v) {
                                                ToastPopUp().toast(
                                                    error.toString(),
                                                    Colors.red,
                                                    Colors.white);
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text('Save',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (value == 'Delete') {
                                db
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove()
                                    .then((v) {
                                  ToastPopUp().toast(
                                      'Data deleted successfully',
                                      Colors.green,
                                      Colors.white);
                                }).onError((error, v) {
                                  ToastPopUp().toast(error.toString(),
                                      Colors.red, Colors.white);
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                    value: 'Edit', child: Text('Edit')),
                                const PopupMenuItem<String>(
                                    value: 'Delete', child: Text('Delete')),
                              ];
                            },
                            icon: const Icon(Icons.more_vert),
                            offset: const Offset(0, 50),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ],
    ));
  }
}
