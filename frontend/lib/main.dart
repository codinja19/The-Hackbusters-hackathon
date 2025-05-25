import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

/// Root app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitSure',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FrontPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// FRONT PAGE — Login Page
class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showLoginPopup(BuildContext context, String username) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Login Successful"),
          content: const Text("You're now signed in!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(username: username),
                  ),
                );
              },
              child: const Text("Continue"),
            ),
          ],
        );
      },
    );
  }

  void _handleLogin() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your credentials")),
      );
      return;
    }

    _showLoginPopup(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/log_image1.png', width: 200),
              ),

              const SizedBox(height: 20),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Roboto',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'HI! WELCOME,',
                          speed: Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'YOUR FITNESS JOURNEY',
                          speed: Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'AWAITS YOU...',
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username, Email or Phone Number',
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text("Remember Me"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Forgot Password? tapped"),
                        ),
                      );
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text("Log In"),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Don't have an account? "),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// SECOND PAGE — Shows welcome and "Start" button
class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('WELCOME'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/second_pg.png',
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText("Your Fitness journey awaits You 😊"),
                ],
                totalRepeatCount: 1,
                pause: const Duration(seconds: 2),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPage(username: username),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF36C3FF), Color(0xFF405AFF)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// THIRD PAGE — Dashboard
class ThirdPage extends StatefulWidget {
  final String username;
  const ThirdPage({super.key, required this.username});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  bool showGoals = false;
  bool showProfile = false;

  void _showDoctorAppointmentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🩺 Doctor Appointment"),
        content: const Text(
          "Dr. Jane Smith\nGeneral Physician\nDate: June 1, 2025\nTime: 11:00 AM\nLocation: XYZ Wellness Center",
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showInsurancePlanPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("💼 Insurance Plan"),
        content: const Text(
          "Health Coverage: ₹5,00,000/year\nProvider: ABC Insurance\nIncludes: Diagnostics, OPD",
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showReplaceInsurancePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🔄 Replace Insurance Plan"),
        content: const Text(
          "New Plan: XYZ Secure+ \nCoverage: ₹10,00,000/year\nBenefits: 24/7 Support, No Claim Bonus",
        ),
        actions: [
          TextButton(
            child: const Text("No, keep plan"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Replace Now"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Plan replaced successfully ✅")),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int totalSteps = 10000;
    const int currentSteps = 3000;
    double stepProgress = currentSteps / totalSteps;

    const int burnedCalories = 350;
    const int goalCalories = 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Expandable Profile
            GestureDetector(
              onTap: () {
                setState(() {
                  showProfile = !showProfile;
                });
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/user_image.png',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              "Hi, ${widget.username} 👋",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            showProfile
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                        ],
                      ),
                      if (showProfile) ...[
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.cake),
                            SizedBox(width: 8),
                            Text("Age: 25"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.favorite),
                            SizedBox(width: 8),
                            Text("Health Score: 87"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.flag),
                            SizedBox(width: 8),
                            Text("Goals: Stay fit & active"),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Circular steps
            Center(
              child: CircularPercentIndicator(
                radius: 100,
                lineWidth: 18,
                percent: stepProgress,
                animation: true,
                animationDuration: 1500,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(stepProgress * 100).toInt()}%",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text("Steps"),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.grey[300]!,
                progressColor: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 30),

            /// Animated Calories Bar
            const Text(
              "🔥 Calories Burnt",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: burnedCalories / goalCalories,
              ),
              duration: const Duration(seconds: 1),
              builder: (context, value, _) {
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        final safeWidth = (maxWidth * value).clamp(
                          0.0,
                          maxWidth,
                        );
                        return Container(
                          width: safeWidth,
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.red, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "$burnedCalories / $goalCalories kcal",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            /// Daily goals
            ElevatedButton.icon(
              icon: const Icon(Icons.flag),
              label: Text(showGoals ? "Hide Daily Goals" : "View Daily Goals"),
              onPressed: () => setState(() => showGoals = !showGoals),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),

            if (showGoals) ...[
              const SizedBox(height: 20),
              const Text(
                "✅ Steps: Walk 10,000 steps",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                "🔥 Burn at least 600 calories",
                style: TextStyle(fontSize: 16),
              ),
            ],

            const SizedBox(height: 30),
            const Text(
              '🎉 Congratulations! You’ve earned rewards for completing your daily fitness goals!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.local_hospital),
              label: const Text("Free Health Check-up + Consultation"),
              onPressed: () => _showDoctorAppointmentPopup(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync_alt),
                    label: const Text("Replace Plan"),
                    onPressed: () => _showReplaceInsurancePopup(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.remove_red_eye),
                    label: const Text("View Plan"),
                    onPressed: () => _showInsurancePlanPopup(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
