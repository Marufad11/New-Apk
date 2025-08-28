import 'package:flutter/material.dart';
import 'package:myapp/scoring_screen.dart';

class NewMatchWizard extends StatefulWidget {
  const NewMatchWizard({super.key});

  @override
  State<NewMatchWizard> createState() => _NewMatchWizardState();
}

class _NewMatchWizardState extends State<NewMatchWizard> {
  final _formKey = GlobalKey<FormState>();

  String? _tossWinner;
  String? _optedTo;
  int? _overs;

  void createMatchSetup(String? tossWinner, String? optedTo, int? overs) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScoringScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cricket scorer'),
        backgroundColor: const Color(0xFF2E7D32),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Teams
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Host Team',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter host team name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Visitor Team',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter visitor team name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Toss Won By?
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Toss Won By?'),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'host',
                            groupValue: _tossWinner,
                            onChanged: (value) => setState(() => _tossWinner = value),
                            activeColor: const Color(0xFF2E7D32),
                          ),
                          const Text('Host Team'),
                          Radio<String>(
                            value: 'visitor',
                            groupValue: _tossWinner,
                            onChanged: (value) => setState(() => _tossWinner = value),
                            activeColor: const Color(0xFF2E7D32),
                          ),
                          const Text('Visitor Team'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Opted To?
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Opted To?'),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'bat',
                            groupValue: _optedTo,
                            onChanged: (value) => setState(() => _optedTo = value),
                            activeColor: const Color(0xFF2E7D32),
                          ),
                          const Text('Bat'),
                          Radio<String>(
                            value: 'bowl',
                            groupValue: _optedTo,
                            onChanged: (value) => setState(() => _optedTo = value),
                            activeColor: const Color(0xFF2E7D32),
                          ),
                          const Text('Bowl'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Overs?
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Overs',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of overs';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _overs = int.tryParse(value ?? ''),
              ),

              const SizedBox(height: 16),

              // Advanced Settings
              ExpansionTile(
                title: const Text('Advanced Settings'),
                children: [
                  // Number of players per side
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Players per side'),
                    keyboardType: TextInputType.number,
                    initialValue: '11',
                  ),

                  // Balls per over
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Balls per over'),
                    keyboardType: TextInputType.number,
                    initialValue: '6',
                  ),

                  // Free-hit toggle after no-ball
                  Row(
                    children: [
                      const Text('Free-hit after no-ball'),
                      Switch(value: true, onChanged: (value) {}),
                    ],
                  ),

                  // Powerplay toggle
                  Row(
                    children: [
                      const Text('Powerplay toggle'),
                      Switch(value: true, onChanged: (value) {}),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Start Match Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      createMatchSetup(_tossWinner, _optedTo, _overs);
                    }
                  },
                  child: const Text('Start Match'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        selectedItemColor: const Color(0xFF2E7D32),
        currentIndex: 0,
      ),
    );
  }
}
