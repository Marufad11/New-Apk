import 'package:flutter/material.dart';
import 'package:myapp/live_scoring_screen.dart';
import 'package:myapp/new_match_wizard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cricket Scorer - Home'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle filter selection
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'date',
                  child: Text('Date'),
                ),
                const PopupMenuItem<String>(
                  value: 'status',
                  child: Text('Status'),
                ),
                const PopupMenuItem<String>(
                  value: 'competition',
                  child: Text('Competition'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual match data
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Match ${index + 1}'),
              subtitle: const Text('Team A vs Team B'),
              trailing: const Text('Live'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LiveScoringScreen()),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewMatchWizard()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
