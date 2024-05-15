// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:countries_info_app/view/custom_widgets/drawer_widget.dart';
import 'package:countries_info_app/view/home/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class DrawerHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Lottie.asset(
              'assets/setting ltiie.json',
              width: 250,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AboutScreen(),
              ));
            },
            child: DrawerItem(text: "About", icon: Icons.info),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              _showExitConfirmationDialog(context);
            },
            child: DrawerItem(text: "Exit", icon: Icons.exit_to_app),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit"),
          content: Text("Are you sure you want to exit?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text("Exit"),
            ),
          ],
        );
      },
    );
  }
}
