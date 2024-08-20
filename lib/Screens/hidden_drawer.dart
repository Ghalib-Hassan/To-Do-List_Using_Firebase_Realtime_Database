import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:to_do_list_smit/Screens/all_tasks.dart';
import 'package:to_do_list_smit/Screens/assigned_to_me.dart';
import 'package:to_do_list_smit/Screens/important.dart';
import 'package:to_do_list_smit/Screens/planned.dart';
import 'package:to_do_list_smit/Screens/todo_list.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: Colors.black,
              name: 'Home',
              baseStyle: GoogleFonts.eagleLake(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              selectedStyle: GoogleFonts.fahkwang(fontSize: 50)),
          const TodoList()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'All Tasks',
            baseStyle: GoogleFonts.eagleLake(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            selectedStyle: GoogleFonts.fahkwang(fontSize: 50)),
        const AllTasks(),
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: Colors.black,
              name: 'Important',
              baseStyle: GoogleFonts.eagleLake(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              selectedStyle: GoogleFonts.fahkwang(fontSize: 50)),
          const ImportantScreen()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Planned',
            baseStyle: GoogleFonts.eagleLake(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            selectedStyle: GoogleFonts.fahkwang(fontSize: 50)),
        const PlannedScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Assigned',
            baseStyle: GoogleFonts.eagleLake(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            selectedStyle: GoogleFonts.fahkwang(fontSize: 50)),
        const AssignedToMeScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      styleAutoTittleName: GoogleFonts.daiBannaSil(
          color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
      backgroundColorAppBar: Colors.blue,
      backgroundColorMenu: Colors.lightBlue,
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}