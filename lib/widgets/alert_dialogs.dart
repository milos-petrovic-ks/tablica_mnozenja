import 'package:flutter/material.dart';

AlertDialog errorMessageDialog(dynamic context, String message) {
  return AlertDialog(
    title: const Text('Greška'),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('OK'),
      ),
    ],
  );
}

AlertDialog confirmChangesDialog(dynamic context, String title, String message, Function onOk) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('NE'),
      ),
      TextButton(
        onPressed: () {
          onOk();
          Navigator.pop(context);
        },
        child: const Text('DA'),
      ),
    ],
  );
}
