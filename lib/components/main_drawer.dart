import 'package:flutter/material.dart';
import 'package:open_gym_project/screens/rpe_calculator.dart';

Widget mainDrawer(BuildContext context){
  return Drawer(
    child: ListView(
      children: [
        SizedBox(
          height: 50,
          child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text("Menu")),
        ),
        ListTile(
          title: const Text("RPE Calculator"),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RPECalculator.route);
          },
        ),
      ],
    ),
  );
}