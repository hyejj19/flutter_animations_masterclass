import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    _visible = !_visible;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Implicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: ColorTween(
                begin: Colors.purple,
                end: Colors.red,
              ),
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 10),
              builder: (context, value, child) {
                return Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/3/3f/Dash_the_dart_mascot.png",
                  color: value,
                  colorBlendMode: BlendMode.colorBurn,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: _trigger, child: Text('go'))
          ],
        ),
      ),
    );
  }
}
