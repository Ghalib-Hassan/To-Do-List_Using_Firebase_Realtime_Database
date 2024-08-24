import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignedToMeScreen extends StatefulWidget {
  const AssignedToMeScreen({super.key});

  @override
  _AssignedToMeScreenState createState() => _AssignedToMeScreenState();
}

class _AssignedToMeScreenState extends State<AssignedToMeScreen> {
  List<String> assignedList = [];
  List<bool> checkedList = [];
  List<String> checkedTasks = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      assignedList = sp.getStringList('assigned') ?? [];
      checkedTasks = sp.getStringList('CheckedTasks') ?? [];
      checkedList = List<bool>.filled(assignedList.length, false);
    });
  }

  Future<void> _saveData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setStringList('assigned', assignedList);
    await sp.setStringList('CheckedTasks', checkedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: assignedList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CheckboxListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    value: checkedList[index],
                    title: Text(
                      assignedList[index],
                      style: GoogleFonts.ubuntu(fontSize: 25),
                    ),
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkedList[index] = newValue!;
                        if (newValue) {
                          checkedTasks.add(assignedList[index]);
                        } else {
                          checkedTasks.remove(assignedList[index]);
                        }
                        _saveData();
                      });
                    },
                    activeColor: Colors.blue,
                    controlAffinity: ListTileControlAffinity.leading,
                    tileColor: checkedList.contains(true)
                        ? Colors.amber.withOpacity(.5)
                        : Colors.blueGrey.withOpacity(.5),
                    secondary: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        TextEditingController controller =
                            TextEditingController(text: assignedList[index]);
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update your response',
                                  style: GoogleFonts.mateSc()),
                              content: TextField(
                                controller: controller,
                                style: GoogleFonts.ubuntu(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: 'Update your task',
                                    labelStyle: GoogleFonts.ubuntu()),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Save'),
                                  onPressed: () {
                                    setState(() {
                                      assignedList[index] = controller.text;
                                      _saveData();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 130,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (checkedTasks.isNotEmpty) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                          itemCount: checkedTasks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                checkedTasks[index],
                                style: GoogleFonts.ubuntu(fontSize: 20),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                child: const Text('Checked Tasks'),
              ),
            ),
          ),
          if (checkedList.contains(true))
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete, size: 50, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      for (int i = checkedList.length - 1; i >= 0; i--) {
                        if (checkedList[i]) {
                          assignedList.removeAt(i);
                        }
                      }
                      _saveData();
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
