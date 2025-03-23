import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animations_masterclass/screens/movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _page = 0.0;
  double _position = 0.0;
  bool isDetailPage = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _hideDetail() {
    setState(() {
      isDetailPage = false;
      _position = 0.0;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta.dy * 0.5;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (_position > 150) {
      setState(() {
        _position = screenHeight;
        isDetailPage = true;
      });
    } else {
      setState(() {
        _position = isDetailPage ? screenHeight : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // 배경 블러 처리
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Container(
              key: ValueKey(_page.floor()),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/covers/${_page.floor() + 1}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(color: Colors.black38),
              ),
            ),
          ),

          // 영화 리스트 페이지
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: (1 - (_position.abs() / 300)).clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, _position),
              child: GestureDetector(
                onVerticalDragUpdate: _onVerticalDragUpdate,
                onVerticalDragEnd: _onVerticalDragEnd,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    double offset = (_page - index);
                    double moveOffset = -50 * offset;

                    return MovieCard(
                      page: _page,
                      moveOffset: moveOffset,
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ),

          // 디테일 페이지
          if (isDetailPage)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              top: isDetailPage ? 0 : screenHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: MovieDetailScreen(
                index: _page.floor(),
                onClose: _hideDetail,
              ),
            ).animate().fadeIn(),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required double page,
    required this.moveOffset,
    required this.index,
  }) : _page = page;

  final double _page;
  final double moveOffset;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.expand_less, color: Colors.white, size: 40),
        const SizedBox(height: 150),
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 300,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Column(
                children: [
                  SizedBox(height: 250),
                  Text(
                    'Awesome movie',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Awesome movie description',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -90,
              child: Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 9),
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage("assets/covers/${index + 1}.jpg"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ).animate(target: _page).move(
                    begin: Offset.zero,
                    end: Offset(moveOffset, 0),
                    duration: 200.ms,
                    curve: Curves.easeOut,
                  ),
            ),
          ],
        ).animate().fadeIn(),
      ],
    );
  }
}
