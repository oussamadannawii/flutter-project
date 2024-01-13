import 'package:flutter/material.dart';
import 'dart:convert';
import 'User.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class AddUser extends StatefulWidget {
  AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() {
    return _AddUserState();
  }
}

class _AddUserState extends State<AddUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String selectedValue = 'M2ata3';

  Future<void> gotouser() async {
    final username = nameController.text;
    final relocation = locationController.text;
    final payment = priceController.text;

    // Check if any of the fields are empty
    if (username.isNotEmpty && relocation.isNotEmpty && payment.isNotEmpty) {
      const String loginUrl = 'http://localhost/WEBAPI/adduser.php';

      final response = await http.post(
        Uri.parse(loginUrl),
        body: {
          'username': username,
          'relocation': relocation,
          'payment': payment,
          'regtype':selectedValue,
      },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == 'done') {
          print(selectedValue);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => User()),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'), // Display an error message
        ),
      );
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()), // Replace MainScreen with the appropriate widget
                );              },
              child: Text('Logout'),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'User Information',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                textAlign: TextAlign.right,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                textAlign: TextAlign.right,
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'User Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                textAlign: TextAlign.right,
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'User Payment',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.yellow,
                child: DropdownButton<String>(
                  value: selectedValue,
                  items: <String>['3eded', 'M2ata3'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue ?? '3eded';
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await gotouser();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register'),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
