import 'package:flutter/material.dart';
import 'package:crud/ShowUsers.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CrudApp() 
    )
  );
}

class CrudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD')),
      body: ShowUsers(),
    );
  }
}
