import 'package:flutter/material.dart';

class TasbeehCounter extends StatefulWidget {
  const TasbeehCounter({super.key});

  @override
  State<TasbeehCounter> createState() => _TasbeehCounterState();
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff231407),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter Circle
            Container(
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffe9c359),
              ),
              child: Center(
                child: Text(
                  '$counter',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff231407),
                  ),
                ),
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 50),

            FloatingActionButton(
              backgroundColor: const Color(0xffe9c359),
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Icon(Icons.add, color: Color(0xff231407)),
            ),

            const SizedBox(height: 20),

            // Reset Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffe9c359),
                foregroundColor: const Color(0xff231407),
              ),
              onPressed: () {
                setState(() {
                  counter = 0;
                });
              },
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
