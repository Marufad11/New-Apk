import 'package:flutter/material.dart';

class ScoringScreen extends StatelessWidget {
  const ScoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoring Screen'),
      ),
      body: const Center(
        child: Text('Scoring Screen Content'),
      ),
    );
  }
}
