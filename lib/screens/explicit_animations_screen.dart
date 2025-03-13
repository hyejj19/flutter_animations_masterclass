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
      seconds: 1,
    ),
  );

  late final Animation<Color?> _color =
      ColorTween(begin: Colors.amber, end: Colors.red)
          .animate(_animationController);

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
              animation: _color,
              builder: (context, child) {
                return Container(
                  color: _color.value,
                  width: 300,
                  height: 300,
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
