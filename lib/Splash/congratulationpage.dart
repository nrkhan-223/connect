import 'package:connect/Const/route.dart';
import 'package:flutter/material.dart';

import '../BottomNav/bottomNavPage.dart';

class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});

  @override
  CongratsPageState createState() => CongratsPageState();
}

class CongratsPageState extends State<CongratsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.orange)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Icon(
                    Icons.celebration_sharp,
                    color: _colorAnimation.value,
                    size: 150.0,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'অভিনন্দন!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আপনি সফল ভাবে মেম্বারশিপ আপডেট করেছেন',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 44,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: () {
                  newPage(context: context, child: const BottomNavPage());
                  // Handle button press
                },
                child: const Text('ফিরে যান',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
