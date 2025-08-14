import 'package:flutter/material.dart';
import 'package:gaagls/view/pages/bookingsPage.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(''), // أو NetworkImage
              ),
              accountName: Text(
                'اسم المستخدم',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('user@example.com'),
            ),
            ListTile(
              leading: const Icon(Icons.save_as, color: Colors.white),
              title: const Text('My Reservation', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('حول التطبيق', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            const Divider(color: Colors.white70),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
              onTap: () {
                // تنفيذ تسجيل الخروج
              },
            ),
          ],
        ),
      ),
    );
  }
}