import 'package:flutter/material.dart';

// 조찬희 템플릿 작성, 최준혁 DB 및 통신 연결
class LoaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
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
            buildDrawerItem(context, Icons.exit_to_app, '로그아웃', null), // 로그아웃 아이템에 route는 null
            buildDrawerItem(context, Icons.account_circle, 'test', '/content')
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerItem(BuildContext context, IconData icon, String text, String? route) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
      onTap: () {
        if (route == null) {
          _showLogoutDialog(context);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('로그아웃 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('예'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

              },
              child: Text('아니요'),
            ),
          ],
        );
      },
    );
  }
}
