import 'package:flutter/material.dart';
import '../../components/navigation_bar.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                _OnboardingPage(
                  title: 'Welcome to MindCare',
                  description: 'Your mental health companion',
                  image: Icons.health_and_safety,
                ),
                _OnboardingPage(
                  title: 'Set Up Profile',
                  description: 'Help us personalize your experience',
                  image: Icons.person_outline,
                ),
                _OnboardingPage(
                  title: 'Get Started',
                  description: 'Start your mental wellness journey',
                  image: Icons.rocket_launch,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _controller.jumpToPage(2),
                child: Text('Skip'),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _currentPage == 2
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainApp()),
                      )
                    : _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData image;

  _OnboardingPage(
      {required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 100, color: Colors.blue),
          SizedBox(height: 30),
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
