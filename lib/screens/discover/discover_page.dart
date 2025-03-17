import 'package:flutter/material.dart';

const _primaryColor = Color(0xFFD00F00);
const _backgroundColor = Color(0xFFFFD8D9);
const _textPrimary = Color(0xFF43170B);
const _textSecondary = Color(0xFF6B3C2C);

class DiscoverPage extends StatelessWidget {
  final String? filter;
  DiscoverPage({this.filter});

  final List<Map<String, dynamic>> _clinics = [
    {'name': 'Sunway Medical', 'address': 'Petaling Jaya', 'sponsored': true},
    {
      'name': 'KL Psychology Center',
      'address': 'Kuala Lumpur',
      'sponsored': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover', style: TextStyle(color: Colors.white)),
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: _backgroundColor,
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _clinics.length,
        itemBuilder: (context, index) => _ClinicTile(clinic: _clinics[index]),
      ),
    );
  }
}

class _ClinicTile extends StatelessWidget {
  final Map<String, dynamic> clinic;
  _ClinicTile({required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(Icons.local_hospital, color: _primaryColor),
        title: Text(clinic['name'], style: TextStyle(color: _textPrimary)),
        subtitle:
            Text(clinic['address'], style: TextStyle(color: _textSecondary)),
        trailing: clinic['sponsored']
            ? Chip(
                label: Text('Sponsored', style: TextStyle(color: Colors.white)),
                backgroundColor: _primaryColor,
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
