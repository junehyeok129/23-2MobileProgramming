import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:loa/initPage.dart';
import 'package:loa/signup.dart';


class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 167.31,
              height: 168.94,
              child: Image.asset('assets/images/ailogo.png'),
            ),
            SizedBox(height: 40),
            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    height: 400,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text("Sign in",
                          style: TextStyle(
                            fontSize: 30,
                          ),),
                        SizedBox(height: 30,),
                        // Input ID Section
                        Container(
                            width: 300,
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Your ID',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        Container(
                            width: 300,
                            child: Row(
                              children: [
                                Text("Your password"),
                                Text("Hide")
                              ],
                            )),
                        Container(
                            width: 300,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Your password',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(height: 30),
                        Container(
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                _login(context);
                              },
                              child: Text('Log in',
                                style: TextStyle(color: Colors.black),),
                            )),
                        SizedBox(width: 300,),
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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Signup()));
                        },
                        child: Text('Create an account',
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

  Future<void> _login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/login'), // 실제 서버 주소로 변경
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InitPage(),
          ),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setBool('isLoggedIn', true);


      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('로그인 실패'),
              content: Text('ID 또는 비밀번호가 일치하지 않습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('에러'),
            content: Text('로그인 실패.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }
}