import 'dart:async';

import 'package:flutter/material.dart';

class ImplicitAnimationChallengeScreen extends StatefulWidget {
  const ImplicitAnimationChallengeScreen({super.key});

  @override
  State<ImplicitAnimationChallengeScreen> createState() =>
      _ImplicitAnimationChallengeScreenState();
}

class _ImplicitAnimationChallengeScreenState
    extends State<ImplicitAnimationChallengeScreen> {
  static const _animationSec = 2;

  bool _isRectangle = false;
  bool _isDark = false;

  void _startBackgroundAnimation() {
    Future.delayed(const Duration(seconds: _animationSec), () {
      if (mounted) {
        setState(() {
          _isDark = !_isDark;
        });
        _startBackgroundAnimation();
      }
    });
  }

  void _startRectangleAnimation() {
    Future.delayed(const Duration(seconds: _animationSec), () {
      if (mounted) {
        setState(() {
          _isRectangle = !_isRectangle;
        });
        _startRectangleAnimation();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startBackgroundAnimation();
    _startRectangleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Implicit Animations Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: _isRectangle ? BoxShape.rectangle : BoxShape.circle,
              ),
              child: AnimatedAlign(
                alignment: _isDark ? Alignment.topRight : Alignment.topLeft,
                duration: Duration(seconds: _animationSec),
                child: Container(
                  width: 20,
                  height: size.width * 0.8,
                  color: _isDark ? Colors.white : Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
