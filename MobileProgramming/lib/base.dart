import 'package:flutter/material.dart';
import 'package:loa/login.dart';
import 'package:loa/signup.dart';
import 'package:loa/listTemplate.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  AppScaffold({required this.body});

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Image.asset('assets/images/menulogo.png'),
            );
          },
        ),
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 140,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30, // 원하는 높이로 조정
                        child: Text(
                          '메뉴',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          // 에셋을 클릭하면 Drawer를 닫도록 함
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/images/menulogo.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Login Page'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Sign up'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('List Template'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListTemplate()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Board Template'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListTemplate()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
