import 'package:flutter/material.dart';
import 'dart:async';
import '../theme.dart';
import 'love_notes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // Example start date: Valentine's Day 2023
  final DateTime startDate = DateTime(2023, 2, 14);
  late Timer _timer;
  Duration _duration = Duration.zero;
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _updateDuration();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDuration();
    });

    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _heartAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _updateDuration() {
    setState(() {
      _duration = DateTime.now().difference(startDate);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _duration.inDays;
    final hours = _duration.inHours % 24;
    final minutes = _duration.inMinutes % 60;
    final seconds = _duration.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Love Story'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoveNotesScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _heartAnimation,
                child: const Icon(
                  Icons.favorite,
                  color: AppTheme.primaryColor,
                  size: 100,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Together For',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTimeItem(days.toString(), 'Days'),
                      _buildTimeItem(hours.toString().padLeft(2, '0'), 'Hours'),
                      _buildTimeItem(minutes.toString().padLeft(2, '0'), 'Mins'),
                      _buildTimeItem(seconds.toString().padLeft(2, '0'), 'Secs'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('❤️ Love sent!'),
                      backgroundColor: AppTheme.primaryColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Send a Hug'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
