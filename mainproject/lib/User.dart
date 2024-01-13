import 'package:flutter/material.dart';
import 'package:mainproject/AddUser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

Future<void> deleteUser(String userId, VoidCallback refreshCallback) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost/WEBAPI/delete.php'),
      body: {'id': userId},
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      if (responsedata['status'] == 'success') {
        print("done");
        refreshCallback(); // Call the callback to refresh data
      } else {
        print('Failed to delete user. Error: ${responsedata['message']}');
      }
    } else {
      print('Failed to delete user. HTTP Status Code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error sending HTTP request: $error');
  }
}

class User extends StatefulWidget {
  User({Key? key}) : super(key: key);

  @override
  _UserState createState() {
    return _UserState();
  }
}

class _UserState extends State<User> {
  List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
      await http.get(Uri.parse('http://localhost/WEBAPI/select.php'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedData = json.decode(response.body);
        setState(() {
          userData = parsedData.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()), // Replace MainScreen with the appropriate widget
                );
              },
              child: Text('Logout'),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Users',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        'Location',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        'Price',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        'Date',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        'Registration Type',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text('Button'),
                    ),
                  ),
                ],
              ),
              for (var data in userData)
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(data['name']),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(data['location']),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(data['payment']),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(data['date']),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(data['RegType']),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                deleteUser(data['id'].toString(), fetchData);
                              },
                              child: Text('Delete'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Handle edit functionality
                              },
                              child: Text('Edit'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUser()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add User'),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle Delete All functionality
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Delete All'),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
