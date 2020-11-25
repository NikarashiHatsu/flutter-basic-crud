import 'dart:convert';
import 'package:crud/FormUser.dart';
import 'package:crud/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowUsers extends StatefulWidget {
  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  Future<void> getUsers() async {
    String url = '$server';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    return jsonData;
  }

  Future<void> deleteUser(userId) async {
    String url = '$server/delete.php?id=$userId';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['message'] == 'success') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('User deleted', style: TextStyle(color: Colors.green)),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete user', style: TextStyle(color: Colors.green)),
      ));
    }

    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 1.0, offset: Offset(1.0, 1.0), spreadRadius: 2.0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Users List', style: Theme.of(context).textTheme.headline6),
                  MaterialButton(
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FormUser(isEdit: false),
                      ));
                      setState(() {});
                    },
                    child: Icon(Icons.person_add, color: Colors.white),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getUsers(),
              initialData: [
                {
                  'username': 'Loading...'
                }
              ],
              builder: (context, snapshot) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${index + 1} - ${data['username']}'),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 16.0),
                              child: MaterialButton(
                                visualDensity: VisualDensity.comfortable,
                                onPressed: () async {
                                  await Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => FormUser(
                                      isEdit: true,
                                      data: data,
                                    ),
                                  ));
                                  setState(() {});
                                },
                                color: Colors.green,
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                            MaterialButton(
                              visualDensity: VisualDensity.comfortable,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete user?'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Text('Are you sure want to delete this user?'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }
                                        ),
                                        MaterialButton(
                                          child: Text('Yes'),
                                          color: Colors.green,
                                          onPressed: () async {
                                            await deleteUser(data['id']);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    );
                  } 
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GetUsers {
  List<User> list = [];

  Future<void> getUsers() async {
    String url = 'http://56d7cce09f95.ngrok.io/';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    jsonData.forEach((element) {
      list.add(
        User(username: element['username'])
      );
    });
  }
}

class User {
  String username;
  
  User({
    this.username
  });
}