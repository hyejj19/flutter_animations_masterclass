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
            AnimatedAlign(
              alignment: _visible ? Alignment.topLeft : Alignment.topRight,
              duration: Duration(milliseconds: 300),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _visible ? 1 : 0,
                child: Container(
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                  color: Colors.amber,
                ),
              ),
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
