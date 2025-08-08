import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/colorscheme.dart';
import 'provider.dart';

class TasbeehCounter extends StatefulWidget {
  const TasbeehCounter({super.key});

  @override
  State<TasbeehCounter> createState() => _TasbeehCounterState();
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter Circle
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColorGold,
              ),
              width: 200,
              height: 200,
              child: Center(
                child: Consumer<AppProvider>(
                  builder: (ctx, _, __) => Text(
                    '${Provider.of<AppProvider>(ctx, listen: true).count}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: primaryColorBlue,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),

            FloatingActionButton(
              backgroundColor: primaryColorGold,
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).increment();
              },
              child: Icon(Icons.add, color: primaryColorBlue),
            ),

            const SizedBox(height: 20),

            // Reset Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColorGold,
                foregroundColor:  primaryColorBlue,
              ),
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).reset();
              },
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
