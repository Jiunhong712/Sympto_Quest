import 'package:flutter/material.dart';

const _primaryColor = Color(0xFFD00F00);
const _backgroundColor = Color(0xFFFFD8D9);
const _textPrimary = Color(0xFF43170B);
const _textSecondary = Color(0xFF6B3C2C);

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  int _points = 150;
  bool _checkedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards', style: TextStyle(color: Colors.white)),
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Your Points',
                        style: TextStyle(fontSize: 18, color: _textSecondary)),
                    SizedBox(height: 8),
                    Text(_points.toString(),
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor)),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _checkedIn
                          ? null
                          : () {
                              setState(() {
                                _points += 10;
                                _checkedIn = true;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(_checkedIn ? 'Checked In!' : 'Daily Check-In',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Available Rewards',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary)),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: List.generate(4, (index) => _RewardCard()),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard, size: 50, color: _primaryColor),
            SizedBox(height: 12),
            Text('RM5 Voucher',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary)),
            SizedBox(height: 8),
            Text('150 points',
                style: TextStyle(fontSize: 14, color: _textSecondary)),
          ],
        ),
      ),
    );
  }
}
