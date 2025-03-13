import 'package:flutter/material.dart';

class ExplicitAnimationsChallengeScreen extends StatefulWidget {
  const ExplicitAnimationsChallengeScreen({super.key});

  @override
  State<ExplicitAnimationsChallengeScreen> createState() =>
      _ExplicitAnimationsChallengeScreenState();
}

class _ExplicitAnimationsChallengeScreenState
    extends State<ExplicitAnimationsChallengeScreen>
    with TickerProviderStateMixin {
  static const int gridSize = 5;
  static const int totalSize = gridSize * gridSize;
  static const int cycleDuration = 2;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: cycleDuration),
  );

  @override
  void initState() {
    super.initState();
    _animationController.repeat(period: const Duration(seconds: cycleDuration));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Explicit Animation Grid')),
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
          ),
          itemCount: totalSize,
          itemBuilder: (context, index) {
            final baseDelay = index / totalSize; // 0~1 사이 값
            final delayFactor = baseDelay * 0.8; // 시작 타이밍 조절

            final opacity = TweenSequence<double>([
              TweenSequenceItem(
                  tween: Tween(begin: 0.0, end: 1.0), weight: 1), // 등장
              TweenSequenceItem(tween: ConstantTween(1.0), weight: 1), // 유지
              TweenSequenceItem(
                  tween: Tween(begin: 1.0, end: 0.0), weight: 1), // 사라짐
            ]).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(delayFactor, 1.0, curve: Curves.easeInOut),
              ),
            );

            return FadeTransition(
              opacity: opacity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
