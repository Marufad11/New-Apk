import 'package:flutter/material.dart';


class LiveScoringScreen extends StatelessWidget {
  const LiveScoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Scoring'),
      ),
      body: Column(
        children: [
          // Scorebar
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Team A 134/4 (16.3) RR 8.1'),
          ),

          // Batsmen Panel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Striker: Player 1'),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Non-Striker: Player 2'),
              ),
            ],
          ),

          // Bowler Panel
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Bowler: Bowler 1'),
          ),

          // Ball Timeline
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Ball Timeline'),
          ),

          // Keypad
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(12, (index) {
                return Center(
                  child: Text('Button ${index + 1}'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
