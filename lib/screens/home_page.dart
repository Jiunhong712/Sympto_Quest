import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, John!'),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How are you feeling today?', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['😊', '😐', '😔', '😭']
                  .map((emoji) => CircleAvatar(child: Text(emoji), radius: 24))
                  .toList(),
            ),
            SizedBox(height: 30),
            Text('Reminders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _ReminderCard(text: 'Take meds after meal at 3pm'),
            SizedBox(height: 20),
            Text('Recommended Programs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _ProgramCard(title: 'Anxiety Management'),
                  _ProgramCard(title: 'Sleep Better'),
                  _ProgramCard(title: 'Mindfulness'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final String text;

  _ReminderCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.notifications_active),
        title: Text(text),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final String title;

  _ProgramCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.fitness_center, size: 40),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
