import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AlertDialog alert(BuildContext context) {
  // TextEditingController haicontroller = TextEditingController();
  return AlertDialog(
    title: const Text('are you sure ..!'),
    actions: [
      TextButton(
        onPressed: () {
          // saved();
          // _taskController.text='';

          Provider.of<AutheticationProvider>(context, listen: false).signOut();
          Navigator.of(context).pop();
        },
        child: const Text('LOG OUT'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('CANCEL'),
      ),
    ],
    elevation: 24.0,
    backgroundColor: Colors.grey[300],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

  //  onPressed: () {
  //             showDialog(
  //               context: context,
  //               builder: (context) => alert(context),
  //             );
  //           },