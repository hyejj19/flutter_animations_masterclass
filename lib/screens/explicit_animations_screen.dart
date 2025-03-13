import 'dart:async';

import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(
      seconds: 10,
    ),
  );

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit animation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _animationController.value,
                  child: Container(
                    color: Colors.amber,
                    width: 300,
                    height: 300,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _play,
            child: Text('Play'),
          ),
          ElevatedButton(
            onPressed: _pause,
            child: Text('pause'),
          ),
          ElevatedButton(
            onPressed: _rewind,
            child: Text('rewind'),
          ),
        ],
      ),
    );
  }
}
