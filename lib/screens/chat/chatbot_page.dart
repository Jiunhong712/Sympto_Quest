import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../discover/discover_page.dart';
import '../rewards/rewards_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as mobile;
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as web;

enum Mood { happy, excited, neutral, sad, anxious }

const _primaryColor = Color(0xFFD00F00);
const _backgroundColor = Color(0xFFFFD8D9);
const _textPrimary = Color(0xFF43170B);
const _textSecondary = Color(0xFF6B3C2C);

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  bool _moodSet = false;
  bool _awaitingMoodResponse = true;
  String? _currentMood;
  int _points = 150;

  @override
  void initState() {
    super.initState();
    _addInitialMessage();
  }

  void _addInitialMessage() {
    _messages.add(ChatMessage(
      text: "Hello! How are you feeling today? 😊\nPlease select your mood:",
      isUser: false,
      showMoodButtons: true,
      onMoodSelected: (mood) => _sendMessage(mood),
    ));
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));

      if (_awaitingMoodResponse) {
        _handleMoodResponse(text);
      } else {
        _handleRegularMessage(text);
      }
    });
  }

  void _handleMoodResponse(String text) {
    final mood = text.toLowerCase();
    String response;
    List<Map<String, String>> recommendations = [];

    switch (mood) {
      case 'happy':
        response = "Great to hear you're feeling happy! 🎉";
        recommendations = [
          {
            'title': 'Mindfulness Exercise',
            'videoId': 'ssss7V1_eyA',
            'description': "Just a simple description."
          },
          {
            'title': 'Gratitude Journaling',
            'videoId': 'WbHM_4rQmcw',
            'description': "Just a simple description."
          },
        ];
        break;
      case 'excited':
        response = "Wonderful to see your excitement! 🌟";
        recommendations = [
          {
            'title': 'Energy Management',
            'videoId': '1aYv2ZpTblk',
            'description': "Just a simple description."
          },
          {
            'title': 'Creative Activities',
            'videoId': 'nqye02H_H6I',
            'description': "Just a simple description."
          },
        ];
        break;
      case 'neutral':
        response = "Let's find something interesting!";
        recommendations = [
          {
            'title': 'Daily Check-in Guide',
            'videoId': 'Hh5hZEvvJDg',
            'description': "Just a simple description."
          },
          {
            'title': 'New Hobbies',
            'videoId': 'x8sSIZpm8ro',
            'description': "Just a simple description."
          },
        ];
        break;
      case 'sad':
        response = "I'm here to help you through this 💙";
        recommendations = [
          {
            'title': 'Comforting Playlist',
            'videoId': '5qap5aO4i9A',
            'description': "Just a simple description."
          },
          {
            'title': 'Self-Care Routine',
            'videoId': 'mF2D9cT4uR4',
            'description': "Just a simple description."
          },
        ];
        break;
      case 'anxious':
        response = "Let's work on calming techniques 💆";
        recommendations = [
          {
            'title': 'Breathing Exercise',
            'videoId': 'tEm0XQO_-VM',
            'description': "Just a simple description."
          },
          {
            'title': 'Grounding Techniques',
            'videoId': 'Hw6LtF7WSjM',
            'description': "Just a simple description."
          },
        ];
        break;
      default:
        response = "Here are some wellness tips:";
        recommendations = [
          {
            'title': 'General Wellness',
            'videoId': 'KlG13kkUvqQ',
            'description': "Just a simple description."
          },
        ];
    }

    _messages.add(ChatMessage(
      text: response,
      isUser: false,
      showOptions: true,
      recommendations: recommendations,
      onRecommendationTap: (id) => _navigateToVideo(context, id),
    ));

    _awaitingMoodResponse = false;
  }

  void _navigateToVideo(
      BuildContext context, Map<String, String> recommendation) {
    if (recommendation['videoId'] == null ||
        recommendation['description'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading activity')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityDetailPage(
          videoId: recommendation['videoId']!,
          description: recommendation['description']!,
        ),
      ),
    );
  }

  void _handleRegularMessage(String text) {
    if (_containsSymptoms(text)) {
      final severity = _determineSymptomSeverity(text);
      String response = _getSymptomResponse(severity);
      List<Map<String, dynamic>> locations = _getRelevantLocations(severity);

      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        showLocations: true,
        locations: locations,
      ));
    } else {
      _messages.add(ChatMessage(
        text: _getGeneralResponse(),
        isUser: false,
      ));
    }
  }

  bool _containsSymptoms(String text) {
    final symptoms = ['pain', 'ache', 'fever', 'dizzy', 'nauseous', 'cough'];
    return symptoms.any((symptom) => text.toLowerCase().contains(symptom));
  }

  String _determineSymptomSeverity(String text) {
    text = text.toLowerCase();
    if (text.contains('severe') || text.contains('emergency')) return 'severe';
    if (text.contains('mild') || text.contains('slight')) return 'mild';
    return 'moderate';
  }

  String _getSymptomResponse(String severity) {
    switch (severity) {
      case 'severe':
        return "⚠️ Please seek immediate medical attention. Here are nearby emergency facilities:";
      case 'moderate':
        return "Consider consulting a healthcare professional. Nearby clinics:";
      default:
        return "For mild symptoms, these pharmacies might help:";
    }
  }

  List<Map<String, dynamic>> _getRelevantLocations(String severity) {
    if (severity == 'severe') {
      return [
        {
          'name': 'General Hospital KL',
          'address': 'Kuala Lumpur',
          'type': 'hospital',
          'sponsored': false
        },
        {
          'name': 'Gleneagles Hospital',
          'address': 'Ampang',
          'type': 'hospital',
          'sponsored': true
        }
      ];
    } else if (severity == 'moderate') {
      return [
        {
          'name': 'Sunway Medical',
          'address': 'Petaling Jaya',
          'type': 'clinic',
          'sponsored': true
        },
        {
          'name': 'KL Psychology Center',
          'address': 'Kuala Lumpur',
          'type': 'clinic',
          'sponsored': false
        }
      ];
    }
    return [
      {
        'name': 'Guardian Pharmacy',
        'address': 'Mid Valley',
        'type': 'pharmacy',
        'sponsored': true
      },
      {
        'name': 'Watsons',
        'address': 'Pavilion KL',
        'type': 'pharmacy',
        'sponsored': false
      }
    ];
  }

  String _getGeneralResponse() {
    final responses = [
      "How does that make you feel?",
      "Let's explore that feeling together.",
      "Would you like to try a breathing exercise?",
      "Remember to practice self-care today."
    ];
    return responses[DateTime.now().second % responses.length];
  }

  void _navigateToDiscover(BuildContext context, String filter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscoverPage(initialFilter: filter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SymptoQuest Assistant',
            style: TextStyle(color: Colors.white)),
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          _PointsBadge(points: _points),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _messages.reversed.toList()[index],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_rounded, color: _primaryColor),
                    onPressed: () => _sendMessage(_textController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool showOptions;
  final bool showLocations;
  final bool showMoodButtons;
  final List<Map<String, dynamic>>? locations;
  final Function(String)? onMoodSelected;
  final List<Map<String, String>>? recommendations;
  final Function(Map<String, String>)? onRecommendationTap;

  const ChatMessage({
    required this.text,
    this.isUser = false,
    this.showOptions = false,
    this.showLocations = false,
    this.showMoodButtons = false,
    this.locations,
    this.onMoodSelected,
    this.recommendations,
    this.onRecommendationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUser ? _primaryColor : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: isUser ? Radius.circular(20) : Radius.circular(4),
                bottomRight: isUser ? Radius.circular(4) : Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : _textPrimary,
                fontSize: 16,
              ),
            ),
          ),
          if (showMoodButtons)
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildMoodButton('😊', 'Happy', Mood.happy),
                  _buildMoodButton('😃', 'Excited', Mood.excited),
                  _buildMoodButton('😐', 'Neutral', Mood.neutral),
                  _buildMoodButton('😞', 'Sad', Mood.sad),
                  _buildMoodButton('😟', 'Anxious', Mood.anxious),
                ],
              ),
            ),
          if (showOptions && recommendations != null)
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: recommendations!
                    .map((rec) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryColor,
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () => onRecommendationTap?.call(rec),
                            child: Text(rec['title']!),
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String label, Mood mood) {
    return TextButton(
      onPressed: () => onMoodSelected?.call(mood.toString().split('.').last),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _PointsBadge extends StatelessWidget {
  final int points;

  const _PointsBadge({required this.points});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RewardsPage()),
        ),
        child: Row(
          children: [
            const Icon(Icons.stars, color: Colors.amber),
            const SizedBox(width: 4),
            Text('$points', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ActivityDetailPage extends StatelessWidget {
  final String videoId;
  final String description;

  const ActivityDetailPage({
    required this.videoId,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Guide')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: kIsWeb
                ? web.YoutubePlayer(
                    controller: web.YoutubePlayerController.fromVideoId(
                      videoId: videoId,
                      autoPlay: true,
                      params: const web.YoutubePlayerParams(
                        showControls: true,
                        showFullscreenButton: true,
                      ),
                    ),
                  )
                : mobile.YoutubePlayer(
                    controller: mobile.YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: const mobile.YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                  ),
          ),
        ],
      ),
    );
  }
}
