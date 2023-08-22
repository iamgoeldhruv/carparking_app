import 'package:flutter/material.dart';


class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashboardItem(icon: Icons.person, label: 'Profile'),
            DashboardItem(icon: Icons.settings, label: 'Settings'),
            DashboardItem(icon: Icons.dashboard, label: 'Dashboard'),
          ],
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;

  DashboardItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 48),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
