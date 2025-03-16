import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('Discover')),
      body: ListView.builder(
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
    return ListTile(
      leading: Icon(Icons.local_hospital),
      title: Text(clinic['name']),
      subtitle: Text(clinic['address']),
      trailing: clinic['sponsored'] ? Chip(label: Text('Sponsored')) : null,
    );
  }
}
