import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/custom_painter_challenge.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_challenge_screen.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/flash_cards_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animation_challenge_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/music_player_screen.dart';
import 'package:flutter_animations_masterclass/screens/swiping_cards_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animations'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ImplicitAnimationsScreen(),
                );
              },
              child: Text('Implicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ImplicitAnimationChallengeScreen(),
                );
              },
              child: Text('Implicit Animations Challenge'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ExplicitAnimationsScreen(),
                );
              },
              child: Text('Explicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ExplicitAnimationsChallengeScreen(),
                );
              },
              child: Text('Explicit Animations Challenge'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  CustomPainterChallengeScreen(),
                );
              },
              child: Text('Custom Painter Challenge'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  SwipingCardsScreen(),
                );
              },
              child: Text('Swiping Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  FlashCardsScreen(),
                );
              },
              child: Text('Flash Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  MusicPlayerScreen(),
                );
              },
              child: Text('Music Player'),
            ),
          ],
        ),
      ),
    );
  }
}
