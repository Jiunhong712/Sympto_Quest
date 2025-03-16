import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('Rewards')),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Your Points', style: TextStyle(fontSize: 18)),
                  Text(_points.toString(),
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: _checkedIn
                        ? null
                        : () => setState(() {
                              _points += 10;
                              _checkedIn = true;
                            }),
                    child: Text(_checkedIn ? 'Checked In!' : 'Daily Check-In'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Available Rewards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard, size: 50),
          Text('RM5 Voucher'),
          Text('150 points'),
        ],
      ),
    );
  }
}
