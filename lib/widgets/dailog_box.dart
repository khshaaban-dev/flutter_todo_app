import 'package:flutter/material.dart';

import 'package:flutter_todo_app/widgets/my_button.dart';

class DailogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DailogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.yellow[300],
        content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Add a new Task',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    buttonText: 'Save',
                    onPressed: onSave,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MyButton(
                    buttonText: 'Cancel',
                    onPressed: onCancel,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
