import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MovieDetailScreen extends StatefulWidget {
  final int index;
  final Function onClose;

  const MovieDetailScreen({
    super.key,
    required this.index,
    required this.onClose,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  double _position = 0.0;
  late AnimationController _animationController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: 300.ms,
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.primaryDelta ?? 0.0;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_position < 100) {
      widget.onClose();
    } else {
      _animationController.forward(from: 0.0);
      setState(() {
        _offsetAnimation =
            Tween<double>(begin: _position, end: 0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ));

        _animationController.addListener(() {
          setState(() {
            _position = _offsetAnimation.value;
          });
        });
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _position),
              child: child,
            );
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: (1 - (_position.abs() / 300)).clamp(0.0, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 배경 이미지
                Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/covers/${widget.index + 1}.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 영화 제목
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Movie Title",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ).animate().fade(duration: 300.ms, begin: 0.0, end: 1.0),

                const SizedBox(height: 10),

                // 영화 설명
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "This is a short description of the movie. It gives an overview of the storyline, key characters, and highlights.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ).animate().slideY(duration: 400.ms, begin: 0.3, end: 0.0),

                const SizedBox(height: 20),

                // 버튼 및 아이콘
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                        ),
                        child: const Text(
                          "Play",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                          .animate()
                          .fade(duration: 500.ms, begin: 0.0, end: 1.0)
                          .slideY(begin: 0.2, end: 0.0),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.white),
                      ).animate().scale(delay: 200.ms),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
