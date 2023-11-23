import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loa/login.dart';


/*
* Need to passwordCheck algorithm
* METHOD
* 1. IN Flutter
*
* 2. Flask
* */
class Signup extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();
  final TextEditingController _studentNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(// AppBar
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 170,
              height: 170,
              child: Image.asset('assets/images/ailogo.png'), // Intro rogo
            ),
            SizedBox(height: 40),
            Container(
              decoration: ShapeDecoration( // Box decoration
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5,color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    //height: 400,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text("Sign up",
                          style: TextStyle(
                            fontSize: 25,
                          ),),
                        SizedBox(height: 30,),
                        // Input ID Section
                        // TextForm Section
                        Container(
                            width: 300,
                            height: 50,
                            child: TextFormField(
                              controller: _idController,
                              decoration: InputDecoration(
                                labelText: 'Your ID',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        Container(
                            width: 300,
                            //child: Row(
                            //  children: [
                            //    Text("Your password"),
                            //    Text("Hide")
                            //  ],
                            //)
                          ),
                        Container(
                            width: 300,
                            height: 50,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Your password',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        // Password Chrck Field
                        // NEED FIX
                        Container(
                            width: 300,
                            height: 50,
                            child: TextFormField(
                              controller: _passwordCheckController,
                              decoration: InputDecoration(
                                labelText: 'Password Check',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        Container(
                            width: 300,
                            height: 50,
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        Container(
                            width: 300,
                            height: 50,
                            child: TextFormField(
                              controller: _studentNumberController,
                              decoration: InputDecoration(
                                labelText: 'Student Number',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          _login(context);
                        },
                        // NEED FIX
                        child: Text('Create (안눌림)', // Not Running
                          style: TextStyle(color: Colors.black),),
                      )),
                  Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login()));
                        },
                        // NEED FIX
                        child: Text('Back', // Now Running... But Navigate just login Page
                          style: TextStyle(color: Colors.black),),
                      )),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // SECTION : DB Connection
  // Need to Flask and SQL Server

  Future<void> _login(BuildContext context) async {
    String id = _idController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String student_num = _studentNumberController.text;

    try {
      final response = await http.post(
        // NEED FIX (SEND, ADDRESS)
        Uri.parse('http://0.0.0.0/signup'), // NEED MODIEFY
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': id,
          'password': password,
          'name' : name,
          'student_num' : student_num
        }),
      );

      if (response.statusCode == 200) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 실패: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('오류: $e'),
        ),
      );
    }
  }
}
