import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crud/server.dart';
import 'package:http/http.dart' as http;

class FormUser extends StatefulWidget {
  final bool isEdit;
  final dynamic data;

  FormUser({
    this.isEdit,
    this.data,
  });
  
  @override
  _FormUserState createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  TextEditingController _usernameController = TextEditingController();
  FocusNode _usernameFocusNode = FocusNode();
  String _title = 'Add User';

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.requestFocus();

    if(widget.isEdit) {
      _usernameController.text = widget.data['username'];
      _title = 'Edit User';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Future<void> _save() async {
      String username = _usernameController.text;
      String url = !widget.isEdit
        ? "$server/store.php?username=$username"
        : "$server/update.php?id=${widget.data['id']}&username=$username";
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);

      if(jsonData['message'] == 'success') {
        Navigator.pop(context);
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 1.0, offset: Offset(1.0, 1.0), spreadRadius: 2.0)
              ],
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_title, style: Theme.of(context).textTheme.headline6),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      onPressed: _save,
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}