import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/counter.dart';
import 'package:quran_app/listen_quran.dart';
import 'package:quran_app/read_quran.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff231407),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "خوش آمدید",
                  style: TextStyle(
                    fontFamily: 'Lateef',
                    fontSize: 48,
                    color: const Color(0xffe9c359),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // Read Quran Button
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color(0xffe9c359),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SurahMenuWritten()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.book,color: Color(0xff231407),size: 45)
                            ,Text(
                              "Read Quran",
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
                ),

                const SizedBox(height: 20),

                // Listen Quran Button
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color(0xffe9c359),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SurahMenuAudio()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.headphones,color: Color(0xff231407),size: 45,
                            ),
                            Text(
                              "Listen Quran",
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
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color(0xffe9c359),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TasbeehCounter()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.timer,color: Color(0xff231407),size: 45)
                            ,Text(
                              "Tasbeeh Counter",
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
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
