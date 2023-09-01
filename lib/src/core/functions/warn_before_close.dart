// warn user with a dialog before closing the app

import 'package:flutter/material.dart';

 onClose(BuildContext context)async{
  return showDialog<bool?>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to exit an App'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
