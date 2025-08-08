import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/colorscheme.dart';
import 'package:quran_app/counter.dart';
import 'package:quran_app/listen_quran.dart';
import 'package:quran_app/namaz_timing.dart';
import 'package:quran_app/provider.dart';
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
      backgroundColor: primaryColorBlue,
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
                    color: primaryColorGold,
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
                  color: primaryColorGold,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahMenuWritten(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              FlutterIslamicIcons.solidQuran2,
                              color: primaryColorBlue,
                              size: 45,
                            ),
                            Text(
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
                  color: primaryColorGold,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => AppProvider(),
                            child: SurahMenuAudio(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.headphones,
                              color: primaryColorBlue,
                              size: 45,
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
                  color: primaryColorGold,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NamazTiming(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              FlutterIslamicIcons.solidPrayingPerson,
                              color: primaryColorBlue,
                              size: 45,
                            ),
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
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: primaryColorGold,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => AppProvider(),
                            child: TasbeehCounter(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              FlutterIslamicIcons.solidTasbihHand,
                              color: primaryColorBlue,
                              size: 45,
                            ),
                            Text(
                              "Tasbeeh",
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
