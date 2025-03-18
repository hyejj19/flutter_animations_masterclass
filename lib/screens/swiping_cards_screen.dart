import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);
  late final Tween<double> _scale = Tween(begin: 0.8, end: 1.0);

  void _onHorizontalDragUpdate(DragUpdateDetails detail) {
    _position.value += detail.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    final bound = size.width - 100;
    final dropzone = size.width + 100;
    final target = _position.value.abs() >= bound
        ? (_position.value.isNegative ? dropzone * -1 : dropzone)
        : 0.0;

    _position.animateTo(target, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swiping Cards'),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          // position 값에 따라서 회전 각도를 계산
          // size.width/2 => 전체 너비의 절반을 더해 현재 position 의 중앙을 기준점으로 함
          // 이를 다시 size.width 로 나누어서 0~1 사이의 비율로 만듦 (어떤 값을 전체 크기로 나누면 비율이 된다는 것...!)
          final angle = _rotation
              .transform((_position.value + size.width / 2) / size.width);
          final scale = _scale.transform(_position.value.abs() / size.width);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: scale,
                  child: Material(
                    elevation: 10,
                    color: Colors.blue.shade100,
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle *
                          pi /
                          180, // 각도를 라디안으로 변환, angle 값에서 호의 개념으로 전환..
                      child: Material(
                        elevation: 10,
                        color: Colors.red.shade100,
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
