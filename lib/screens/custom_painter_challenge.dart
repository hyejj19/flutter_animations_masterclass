import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CustomPainterChallengeScreen extends StatefulWidget {
  const CustomPainterChallengeScreen({super.key});

  @override
  State<CustomPainterChallengeScreen> createState() =>
      _CustomPainterChallengeScreenState();
}

class _CustomPainterChallengeScreenState
    extends State<CustomPainterChallengeScreen>
    with SingleTickerProviderStateMixin {
  Timer? timer; // 타이머 객체
  static const int initSec = 10; // 초기 타이머 시간 (10초)
  int sec = initSec; // 현재 남은 시간
  bool isRunning = false; // 타이머 실행 여부
  bool isStop = false; // 타이머가 멈췄는지 여부

  late AnimationController _animationController;
  late Animation<double> _progress;

  /// 애니메이션 컨트롤러를 재생성하여 시간을 초기화하는 함수
  void _updateAnimationController() {
    _animationController.dispose(); // 기존 컨트롤러 해제
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: sec), // 남은 시간 기준으로 설정
    );
    _progress = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  /// 타이머 시작
  void _onPlay() {
    if (isStop) {
      sec = initSec; // 타이머가 멈춘 상태에서 다시 시작하면 초기화
      _updateAnimationController();
    }

    timer = Timer.periodic(Duration(seconds: 1), onTick); // 매 초마다 onTick 실행
    _animationController.forward(from: 0); // 애니메이션 시작
    isRunning = true;
    isStop = false;
    setState(() {});
  }

  /// 1초마다 실행되는 타이머 콜백
  void onTick(Timer? timer) {
    sec -= 1; // 1초 감소
    if (sec == 0) {
      timer?.cancel(); // 0초가 되면 타이머 정지
      _onStop();
    }
    setState(() {});
  }

  /// 타이머 일시 정지
  void _onPause() {
    timer?.cancel(); // 타이머 중지
    isRunning = false;
    isStop = false;
    _animationController.stop(); // 애니메이션 정지
    setState(() {});
  }

  /// 타이머 정지
  void _onStop() {
    timer?.cancel(); // 타이머 중지
    isRunning = false;
    isStop = true;
    _animationController.stop(); // 애니메이션 정지
    setState(() {});
  }

  /// 타이머 초기화
  void _onReset() {
    timer?.cancel(); // 타이머 중지
    sec = initSec; // 시간 초기화
    _updateAnimationController(); // 애니메이션 컨트롤러 재설정
    isRunning = false;
    isStop = false;
    _animationController.value = 0; // 애니메이션 초기화
    _animationController.stop();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: sec),
    );
    _progress = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Custom Painter Challenge")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // 타이머 진행 상황을 표시하는 CustomPaint
                AnimatedBuilder(
                  animation: _progress,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: TimerPainter(progress: _progress.value),
                      size: Size(size.width * 0.8, size.width * 0.8),
                    );
                  },
                ),
                // 타이머 남은 시간 표시
                Text(
                  "${(sec ~/ 60).toString().padLeft(2, '0')}:${(sec % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: _onReset, // 타이머 초기화
                  icon: Icon(Icons.replay),
                ),
                IconButton(
                  iconSize: 80,
                  onPressed: !isRunning ? _onPlay : _onPause, // 시작/일시정지
                  icon: Icon(!isRunning ? Icons.play_arrow : Icons.pause),
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: _onStop, // 정지
                  icon: Icon(Icons.stop),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 타이머 진행 상황을 그림으로 표시하는 CustomPainter
class TimerPainter extends CustomPainter {
  final double progress;
  TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.8;

    // 배경 원
    final backgroundCircle = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    // 진행 원호 (프로그레스 바)
    final progressArc = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // 배경 원 그림
    canvas.drawCircle(center, radius, backgroundCircle);

    // 진행률을 나타내는 원호 그림
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // 12시 방향에서 시작
      progress * 2 * pi, // 진행률에 따라 각도 조정
      false,
      progressArc,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) => true;
}
