import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_moor/data/moor_db.dart';

class InputTask extends StatefulWidget {
  const InputTask({Key key}) : super(key: key);
  @override
  _InputTaskState createState() => _InputTaskState();
}

class _InputTaskState extends State<InputTask> {
  DateTime newTaskDate;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTextField(context),
          _buildDateButton(context),
          _buildSendBtn(context)
        ],
      ),
    );
  }

  Widget _buildTextField(context) {
    final database = Provider.of<AppDatabase>(context);

    return Expanded(
        child: TextField(
      controller: _controller,
      decoration: InputDecoration(hintText: "Task name"),
      onSubmitted: (inputName) {
        final task = Task(
          name: _controller.text.toString(),
          dueDate: newTaskDate,
        );

        database.insertTask(task);
        //  print("Result $result");
        resetAfterSubmit();
        print("OnSubmitted");
      },
    ));
  }

  _buildDateButton(context) {
    return IconButton(
        icon: Icon(Icons.calendar_today),
        onPressed: () async {
          newTaskDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010),
              lastDate: DateTime(2050));
        });
  }

  void resetAfterSubmit() {
    setState(() {
      newTaskDate = null;
      _controller.clear();
    });
  }

  _buildSendBtn(context) {
    return IconButton(icon: Icon(Icons.send), onPressed: () {});
  }
}
