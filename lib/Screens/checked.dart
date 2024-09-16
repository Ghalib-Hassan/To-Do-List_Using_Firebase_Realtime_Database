import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Utils/colors.dart';

class CheckedScreen extends StatefulWidget {
  const CheckedScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckedScreenState createState() => _CheckedScreenState();
}

class _CheckedScreenState extends State<CheckedScreen> {
  final DatabaseReference db = FirebaseDatabase.instance.ref('TodoList');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: db.orderByChild('completed').equalTo(true).onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            final tasks = snapshot.data!.snapshot.children.toList();

            if (tasks.isEmpty) {
              return const Center(child: Text('No Task found'));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                int colorIndex = index % colors.length;
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: colors[colorIndex],
                    ),
                    child: Center(
                      child: Text(
                        task
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
                    task.child('Title').value.toString(),
                    style: GoogleFonts.ubuntuMono(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 1.5),
                  ),
                  subtitle: Text(
                    task.child('Description').value.toString(),
                    style: GoogleFonts.ubuntuMono(
                      fontSize: 17,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
