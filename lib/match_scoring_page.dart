import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the basic app structure and Material Design components.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Advanced Login UI',
      theme: ThemeData(
        // Define a custom color scheme
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: Colors.deepOrangeAccent,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        // Use a consistent font family for a clean look
        fontFamily: 'Roboto',
        // Define styles for text fields and buttons
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          labelStyle: TextStyle(color: Colors.deepPurple.shade300),
          hintStyle: TextStyle(color: Colors.deepPurple.shade300),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Button color
            foregroundColor: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // Define named routes for easier navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/match_scoring': (context) => const MatchScoringPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeySignup = GlobalKey<FormState>();

  late TabController _tabController;

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController = TextEditingController();
  final TextEditingController _phoneLoginController = TextEditingController();

  final TextEditingController _emailSignupController = TextEditingController();
  final TextEditingController _passwordSignupController = TextEditingController();
  final TextEditingController _nameSignupController = TextEditingController();
  final TextEditingController _phoneSignupController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Initialize the TabController to manage the login/signup tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Clean up controllers and tab controller
    _emailLoginController.dispose();
    _passwordLoginController.dispose();
    _phoneLoginController.dispose();
    _emailSignupController.dispose();
    _passwordSignupController.dispose();
    _nameSignupController.dispose();
    _phoneSignupController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Common navigation function to handle login/signup logic
  void _handleLoginOrSignup(BuildContext context, String method) async {
    // Safely get references to ScaffoldMessenger and Navigator before the async gap.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    
    messenger.showSnackBar(
      SnackBar(content: Text('Processing $method...')),
    );
    
    // Simulate an async operation like an API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text('$method Successful!')),
    );

    // Navigate to the match scoring page after a brief delay
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }
    
    navigator.pushNamed('/match_scoring');
  }

  // Method for guest login
  void _handleGuestLogin() {
    // This is a synchronous function, so using context here is always safe.
    final navigator = Navigator.of(context);
    navigator.pushNamed('/match_scoring');
  }

  // Widget to build the login form
  Widget _buildLoginForm() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAuthTabs(
            [
              _buildEmailLoginFields(),
              _buildPhoneLoginFields(),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKeyLogin.currentState!.validate()) {
                if (_tabController.index == 0) { // Email login
                  _handleLoginOrSignup(context, 'Email Login');
                } else { // Phone login
                  _handleLoginOrSignup(context, 'Phone Login');
                }
              }
            },
            child: const Text('LOG IN'),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: _handleGuestLogin,
            child: const Text(
              'Continue as Guest',
              style: TextStyle(color: Colors.deepPurple, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the sign up form
  Widget _buildSignupForm() {
    return Form(
      key: _formKeySignup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAuthTabs(
            [
              _buildEmailSignupFields(),
              _buildPhoneSignupFields(),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKeySignup.currentState!.validate()) {
                if (_tabController.index == 0) { // Email sign up
                  _handleLoginOrSignup(context, 'Email Sign Up');
                } else { // Phone sign up
                  _handleLoginOrSignup(context, 'Phone Sign Up');
                }
              }
            },
            child: const Text('CREATE ACCOUNT'),
          ),
        ],
      ),
    );
  }

  // Helper widget to create the tab-based input fields
  Widget _buildAuthTabs(List<Widget> children) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepPurple,
          tabs: const [
            Tab(text: 'Email'),
            Tab(text: 'Phone Number'),
          ],
        ),
        SizedBox(
          height: 250, // Fixed height to prevent overflow
          child: TabBarView(
            controller: _tabController,
            children: children,
          ),
        ),
      ],
    );
  }

  // Login fields for email and password
  Widget _buildEmailLoginFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          TextFormField(
            controller: _emailLoginController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordLoginController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Login fields for phone number
  Widget _buildPhoneLoginFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          TextFormField(
            controller: _phoneLoginController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              // Simple validation for phone number length
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordLoginController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Sign up fields for email and password
  Widget _buildEmailSignupFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          TextFormField(
            controller: _nameSignupController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailSignupController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordSignupController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Sign up fields for phone number
  Widget _buildPhoneSignupFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          TextFormField(
            controller: _nameSignupController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _phoneSignupController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordSignupController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This is the main UI. It uses a Stack to layer the background and the content.
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)], // Dark purple to purple
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // Top decorative wave/circle and text
                const SizedBox(height: 100),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                // The main card for login/signup forms
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabController,
                              labelColor: Colors.deepPurple,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.deepPurple,
                              tabs: const [
                                Tab(text: 'Login'),
                                Tab(text: 'Create Account'),
                              ],
                            ),
                            SizedBox(
                              height: 600, // This height must be large enough to contain the forms
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  _buildLoginForm(),
                                  _buildSignupForm(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatchScoringPage extends StatefulWidget {
  const MatchScoringPage({super.key});

  @override
  MatchScoringPageState createState() => MatchScoringPageState();
}

class MatchScoringPageState extends State<MatchScoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cricket Scorer - Match Scoring'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.sports_cricket, color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          'Match Scoring UI will be here',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
