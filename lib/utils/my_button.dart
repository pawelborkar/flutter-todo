import 'package:flutter/material.dart';

@immutable
class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed; // returns nothing

  // Constructor
  const MyButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        height: 48,
        minWidth: 112,
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.amberAccent, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
