import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_moor/data/moor_db.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => AppDatabase(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              typography: Typography.material2018(),
            ),
            title: 'Moor',
            home: Home()));
  }
}
