import 'package:flutter/material.dart';

class LoaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      child: Container(
        color: Colors.white,
          child : ListView(
            padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("메뉴"),
                  Icon(Icons.menu),
                ],
              ),
            ),

          ),
          buildDrawerItem(context, Icons.home, 'Home', '/init'),
          buildDrawerItem(context, Icons.shopping_bag_outlined, '퀴즈', '/quiz'),
          buildDrawerItem(context, Icons.query_stats, 'Q & A', '/question'),
          buildDrawerItem(context, Icons.note_alt_outlined, '노트 공유', '/sharenote'),
          buildDrawerItem(context, Icons.note_alt_outlined, '게시판', '/board'),
          buildDrawerItem(context, Icons.note_alt_outlined, 'pick', '/pick'),
        ],
      )),
    );
  }

  ListTile buildDrawerItem(BuildContext context, IconData icon, String text, String route) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
