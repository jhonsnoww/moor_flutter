import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tasks_moor/inputtask.dart';

import 'data/moor_db.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Column(
        children: [Expanded(child: _buildTaskList(context)), InputTask()],
      ),
    );
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
        stream: database.watchAllTask(),
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          final tasks = snapshot.data ?? List();
          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final itemTask = tasks[index];
                return _buildListItem(itemTask, database);
              });
        });
  }

  Widget _buildListItem(Task itemTask, AppDatabase database) {
    return Slidable(
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => database.deleteTask(itemTask),
          )
        ],
        child: CheckboxListTile(
            value: itemTask.completed,
            title: Text(itemTask.name),
            subtitle: Text(itemTask.dueDate?.toString() ?? 'No Date'),
            onChanged: (newValue) {
              database.updateTask(itemTask.copyWith(completed: newValue));
            }),
        actionPane: SlidableDrawerActionPane());
  }
}
