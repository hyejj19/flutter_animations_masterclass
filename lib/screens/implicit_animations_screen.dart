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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              width: _visible ? size.width : size.width * 0.8,
              height: _visible ? size.width : size.width * 0.8,
              transform: Matrix4.rotationZ(_visible ? 1 : 0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _visible ? Colors.red : Colors.amber,
                  borderRadius: BorderRadius.circular(_visible ? 300 : 0)),
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
