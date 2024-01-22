import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      content: SizedBox(
        height: 160,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onSubmitted: (_) => widget.onSave(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                hintText: "Add new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  label: "Save",
                  onPressed: widget.onSave,
                ),
                const SizedBox(width: 8), // Added a small space between buttons
                MyButton(
                  label: "Cancel",
                  onPressed: widget.onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );  
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Focus on the TextField when the dialog is shown
    _focusNode.requestFocus();
  }
}
