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
  // List<String> importantTasks = [];
  // List<String> plannedTasks = [];
  // List<String> assignedTasks = [];

  // Future<void> loadTasks() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   setState(() {
  //     importantTasks = sp.getStringList('important') ?? [];
  //     plannedTasks = sp.getStringList('planned') ?? [];
  //     assignedTasks = sp.getStringList('assigned') ?? [];
  //   });
  // }

  DatabaseReference db = FirebaseDatabase.instance.ref('Todo');

  @override
  Widget build(BuildContext context) {
    // List<String> allTasks = [
    //   ...importantTasks,
    //   ...plannedTasks,
    //   ...assignedTasks,
    // ];

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
              query: db,
              itemBuilder: (context, snapshot, _, index) {
                if (snapshot.value == null) {
                  print(snapshot.value);
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
                } else {
                  print(snapshot.value);

                  int colorIndex = index % colors.length;

                  String todoText =
                      snapshot.child('Todo').value?.toString().trim() ?? '!';
                  String firstLetter = todoText.isNotEmpty
                      ? todoText.substring(0, 1).toUpperCase()
                      : '!';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            firstLetter,
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
                        snapshot.child('name').value.toString(),
                        style: GoogleFonts.ubuntuMono(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        todoText,
                        style: GoogleFonts.ubuntuMono(fontSize: 17),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Edit') {
                            // Add edit logic here
                          } else if (value == 'Delete') {
                            db
                                .child(snapshot.child('id').value.toString())
                                .remove()
                                .then((v) {
                              ToastPopUp().toast('Data deleted successfully',
                                  Colors.green, Colors.white);
                            }).onError((error, v) {
                              ToastPopUp().toast(
                                  error.toString(), Colors.red, Colors.white);
                            });
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                        icon: const Icon(Icons.more_vert),
                        offset: const Offset(0, 50),
                      ),
                    ),
                  );
                }
              }),
        )
      ],
    )
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: allTasks.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                   width: 2, color: Colors.grey.withOpacity(.5))),
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text(
        //               allTasks[index],
        //               style: GoogleFonts.ubuntuMono(fontSize: 20),
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        );
  }
}


///Extra
// if (snapshot.child('Todo').value == null) {
                  //   return Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ListTile(
                  //       leading: Container(
                  //         width: 40,
                  //         height: 40,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(50),
                  //             color: colors[index]),
                  //         child: Center(
                  //           child: Text(
                  //             '!',
                  //             style: GoogleFonts.poppins(fontSize: 20),
                  //           ),
                  //         ),
                  //       ),
                  //       title: Text(
                  //         snapshot.child('name').value.toString(),
                  //         style: GoogleFonts.ubuntuMono(
                  //             fontSize: 20, fontWeight: FontWeight.bold),
                  //       ),
                  //       subtitle: Text(
                  //         '',
                  //         style: GoogleFonts.ubuntuMono(fontSize: 17,color: white,
                  //               fontWeight: FontWeight.bold),
                  //       ),
                  //       trailing: PopupMenuButton<String>(
                  //         onSelected: (String value) {
                  //           if (value == 'Edit') {
                  //           } else if (value == 'Delete') {
                  //             print(snapshot.child('id').value.toString());
                  //             db
                  //                 .child(snapshot.child('id').value.toString())
                  //                 .remove()
                  //                 .then((v) {
                  //               ToastPopUp().toast('Data deleted successfully',
                  //                   Colors.green, Colors.white);
                  //               print(snapshot.child('id').value.toString());
                  //             }).onError((error, v) {
                  //               ToastPopUp().toast(
                  //                   error.toString(), Colors.red, Colors.white);
                  //             });
                  //           }
                  //         },
                  //         itemBuilder: (BuildContext context) {
                  //           return <PopupMenuEntry<String>>[
                  //             const PopupMenuItem<String>(
                  //               value: 'Edit',
                  //               child: Text('Edit'),
                  //             ),
                  //             const PopupMenuItem<String>(
                  //               value: 'Delete',
                  //               child: Text('Delete'),
                  //             ),
                  //           ];
                  //         },
                  //         icon: const Icon(Icons.more_vert),
                  //         offset: const Offset(0, 50),
                  //       ),
                  //     ),
                  //   );
                  // }
