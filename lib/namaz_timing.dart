import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/colorscheme.dart';

class NamazTiming extends StatefulWidget {
  const NamazTiming({super.key});

  @override
  State<NamazTiming> createState() => _NamazTimingState();
}

class _NamazTimingState extends State<NamazTiming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Namaaz Timing',
          style: TextStyle(color: primaryColorGold, fontFamily: 'Lateef'),
        ),
        backgroundColor: primaryColorBlue,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: primaryColorGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: primaryColorGold,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          // Icon(
                          //   Icons.,
                          //   color: primaryColorBlue,
                          //   size: 45,
                          // ),
                          Text(
                            "Prayer Times",
                            style: TextStyle(
                              fontFamily: 'Lateef',
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}