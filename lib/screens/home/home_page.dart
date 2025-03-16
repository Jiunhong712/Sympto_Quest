import 'package:flutter/material.dart';
import '../rewards/rewards_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, Map<String, dynamic>> emojiResponses = {
    '😄': {
      'quote': "That's wonderful! Keep up the positive energy!",
      'needsSupport': false,
    },
    '🙂': {
      'quote': "Good to hear you're doing well! Keep it up!",
      'needsSupport': false,
    },
    '😐': {
      'quote': "Everyone has neutral days. Take some time for yourself.",
      'needsSupport': true,
    },
    '😔': {
      'quote':
          "I'm sorry you're feeling down. Remember that it's okay to not be okay.",
      'needsSupport': true,
    },
    '😭': {
      'quote': "I'm here for you. Remember that difficult times are temporary.",
      'needsSupport': true,
    },
  };

  String? selectedEmoji;
  bool showResponse = false;

  void _handleEmojiSelection(String emoji) {
    setState(() {
      selectedEmoji = emoji;
      showResponse = true;
    });
  }

  void _navigateToChatbot(BuildContext context) {
    // Navigate to chatbot page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatbotPage()),
    );
  }

  void _navigateToProgramDetails(BuildContext context, String title) {
    // Navigate to program details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailsPage(programTitle: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, John!'),
        actions: [
          _PointsBadge(),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How are you feeling today?', style: TextStyle(fontSize: 18)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['😄', '🙂', '😐', '😔', '😭']
                  .map((emoji) => InkWell(
                        onTap: () => _handleEmojiSelection(emoji),
                        child: CircleAvatar(
                          backgroundColor: selectedEmoji == emoji
                              ? Colors.blue.shade200
                              : Colors.grey.shade200,
                          child: Text(emoji, style: TextStyle(fontSize: 24)),
                          radius: 28,
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Show response after emoji selection
            if (showResponse && selectedEmoji != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      emojiResponses[selectedEmoji]!['quote'],
                      style: TextStyle(fontSize: 16),
                    ),
                    if (emojiResponses[selectedEmoji]!['needsSupport'])
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Would you like to talk to our support chatbot?',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showResponse = false;
                                  });
                                },
                                child: Text('No, thanks'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => _navigateToChatbot(context),
                                child: Text('Yes, please'),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
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
                  _ProgramCard(
                    title: 'Anxiety Management',
                    onTap: () => _navigateToProgramDetails(
                        context, 'Anxiety Management'),
                  ),
                  _ProgramCard(
                    title: 'Sleep Better',
                    onTap: () =>
                        _navigateToProgramDetails(context, 'Sleep Better'),
                  ),
                  _ProgramCard(
                    title: 'Mindfulness',
                    onTap: () =>
                        _navigateToProgramDetails(context, 'Mindfulness'),
                  ),
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
  final VoidCallback onTap;

  _ProgramCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
              Spacer(),
              Text('Tap to learn more',
                  style: TextStyle(fontSize: 12, color: Colors.blue[800])),
            ],
          ),
        ),
      ),
    );
  }
}

// New pages for navigation

class ChatbotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Chatbot'),
      ),
      body: Center(
        child: Text('Chatbot interface would go here'),
      ),
    );
  }
}

class ProgramDetailsPage extends StatelessWidget {
  final String programTitle;

  ProgramDetailsPage({required this.programTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About this program',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This program helps you learn techniques to manage your ${programTitle.toLowerCase()}. '
              'Follow along with the video below for a guided session.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_fill, size: 50),
                  SizedBox(height: 8),
                  Text('YouTube Video Embedded Here'),
                  SizedBox(height: 8),
                  Text('(In a real app, use youtube_player_flutter package)'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Key takeaways:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Practice this technique daily for best results'),
            _buildBulletPoint('Set aside at least 10 minutes in a quiet space'),
            _buildBulletPoint('Consistency is key to seeing improvement'),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class _PointsBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RewardsPage()),
        ),
        child: Row(
          children: [
            Icon(Icons.stars, color: Colors.amber),
            SizedBox(width: 4),
            Text('150', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
