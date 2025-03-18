import 'dart:math';
import 'package:flutter/material.dart';

class FlashCardsScreen extends StatefulWidget {
  const FlashCardsScreen({super.key});

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  bool _isFlipped = false;

  late final AnimationController _flipController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<double> _flipAnimation =
      Tween(begin: 0.0, end: pi).animate(_flipController);

  void _flipCard() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  Widget _renderFront() {
    return _cardContainer('question');
  }

  Widget _renderBack() {
    return _cardContainer('answer');
  }

  Widget _cardContainer(String text) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      width: size.width * 0.8,
      height: size.width * 0.9,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Flash Cards'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, child) {
              final isFront = _flipAnimation.value < pi / 2;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0012)
                  ..rotateY(_flipAnimation.value),
                child: isFront
                    ? _renderFront()
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: _renderBack(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
