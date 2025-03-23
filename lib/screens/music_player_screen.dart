import 'dart:ui';

import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );

  int _currentPage = 0;
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Container(
              key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/covers/${_currentPage + 1}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _scroll,
                    builder: (context, scroll, child) {
                      final diff = (scroll - index).abs();
                      final scale = 1 - diff * 0.6;

                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 9),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/covers/${index + 1}.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 9),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("assets/covers/${index + 1}.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Interstella',
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hans zimmer',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
