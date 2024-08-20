import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController addController = TextEditingController();
  String textfield = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const Image(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
            image: NetworkImage(
                'https://images.pexels.com/photos/210661/pexels-photo-210661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Center(
                child: GlassContainer(
                  width: 300,
                  borderGradient: const LinearGradient(
                      colors: [Colors.black, Colors.white]),
                  blur: 900,
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Transform(
                          transform: Matrix4.rotationZ(0.2),
                          child: Image.network(
                              height: 100,
                              'https://cdn.pixabay.com/photo/2022/05/22/17/22/to-do-7214069_1280.png'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GlassText(
                          'Focus on your day',
                          style: GoogleFonts.maitree(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: GlassText(
                            'Get things done with My Day, a \nlist that refresher every day',
                            style: GoogleFonts.mateSc(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 230,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: GoogleFonts.roboto(fontSize: 20),
                  controller: addController,
                  decoration: InputDecoration(
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(Icons.add),
                      onSelected: (String value) async {
                        String enteredText = addController.text;
                        if (enteredText.isNotEmpty) {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();

                          switch (value) {
                            case 'Important':
                              List<String>? importantList =
                                  sp.getStringList('important') ?? [];
                              importantList.add(enteredText);
                              await sp.setStringList(
                                  'important', importantList);
                              break;
                            case 'Planned':
                              List<String>? plannedList =
                                  sp.getStringList('planned') ?? [];
                              plannedList.add(enteredText);
                              await sp.setStringList('planned', plannedList);
                              break;
                            case 'Assigned-to-me':
                              List<String>? assignedList =
                                  sp.getStringList('assigned') ?? [];
                              assignedList.add(enteredText);
                              await sp.setStringList('assigned', assignedList);
                              break;
                          }

                          List<String>? existingList =
                              sp.getStringList(value) ?? [];

                          existingList.add(enteredText);

                          await sp.setStringList(value, existingList);

                          addController.clear();
                        }

                        print("Text saved to $value location");
                      },
                      itemBuilder: (BuildContext context) {
                        return const <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Important',
                            child: Text('Important'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Planned',
                            child: Text('Planned'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Assigned-to-me',
                            child: Text('Assigned to me'),
                          ),
                        ];
                      },
                      offset: const Offset(0, -170),
                    ),

                    //  IconButton(
                    //   onPressed: () async {
                    //     // whereToAdd(context);
                    //     SharedPreferences sp =
                    //         await SharedPreferences.getInstance();
                    //     sp.setString('Add task', addController.text);
                    //   },
                    //   icon: Icon(Icons.add),
                    // ),
                    hintText: "Try typing 'Pay utilities bill by Friday 6pm'",
                    hintStyle: GoogleFonts.roboto(fontSize: 15),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // ElevatedButton(onPressed: () {}, child: Text('Add Task'))
            ],
          ),
        )
      ],
    ));
  }
}