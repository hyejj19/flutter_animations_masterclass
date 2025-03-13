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

  late final Animation<Decoration> _decoration = DecorationTween(
      begin: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      end: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(120),
      )).animate(_animationController);

  late final Animation<double> _rotation =
      Tween(begin: 0.0, end: 2.0).animate(_animationController);

  late final Animation<double> _scale =
      Tween(begin: 0.5, end: 2.0).animate(_animationController);

  late final Animation<Offset> _offset =
      Tween(begin: Offset.zero, end: Offset(0, -0.5))
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            child: SlideTransition(
              position: _offset,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                      decoration: _decoration,
                      child: SizedBox(
                        width: 300,
                        height: 300,
                      )),
                ),
              ),
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
