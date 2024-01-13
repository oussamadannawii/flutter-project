import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اشتراك الايمان',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   TextEditingController usernameController =TextEditingController ();
   TextEditingController passwordController =TextEditingController();

  Future<void> _login() async {
    const String loginUrl = 'http://localhost/WEBAPI/api.php';
    final response = await http.post(
      Uri.parse(loginUrl),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => User()),
        );
      } else {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Alert Title'),
              content: Text('Incorrect Username or Password.'),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                  }, child: ElevatedButton(onPressed: (){
                  usernameController.clear();
                  passwordController.clear();
                  Navigator.of(context).pop();

                }, child: Text('OK')))
              ],
            );
          });

        // Handle login failure
        // Show error message or do other actions
      }
    } else {print('connection  failed');
      // Handle login API failure
      // Show error message or do other actions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('اشتراك الايمان', textAlign: TextAlign.center,),
              ],
            )
        ),
      ),
      body: Padding(

        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            SizedBox(height: 20),
            TextFormField(
              textAlign: TextAlign.left,
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'UserName or email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              textAlign: TextAlign.left,
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.yellow),
              onPressed: () async {
                await _login();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
