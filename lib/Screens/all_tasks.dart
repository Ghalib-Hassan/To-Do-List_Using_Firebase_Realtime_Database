import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  List<String> importantTasks = [];
  List<String> plannedTasks = [];
  List<String> assignedTasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      importantTasks = sp.getStringList('important') ?? [];
      plannedTasks = sp.getStringList('planned') ?? [];
      assignedTasks = sp.getStringList('assigned') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> allTasks = [
      ...importantTasks,
      ...plannedTasks,
      ...assignedTasks,
    ];

    return Scaffold(
      body: Expanded(
        child: ListView.builder(
          itemCount: allTasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: Colors.grey.withOpacity(.5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    allTasks[index],
                    style: GoogleFonts.ubuntuMono(fontSize: 20),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
