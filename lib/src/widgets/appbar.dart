import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/pages/bugs.dart';
import 'package:meizusucks_web/src/pages/donaters.dart';
import 'package:meizusucks_web/src/pages/download.dart';
import 'package:meizusucks_web/src/pages/notes.dart';
import 'package:meizusucks_web/src/pages/root.dart';
import 'package:meizusucks_web/src/widgets/language_selector.dart';

class MzAppBar extends StatelessWidget {
  const MzAppBar({Key? key, required this.screenWidth}) : super(key: key);

  final double barHeight = 50.0;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    final bool verySmallDevice = screenWidth < 400;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appBarGradLeftC,
            appBarGradRightC,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Text(
                screenWidth > 700 ? "MEIZUSUCKS" : "MS",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: (statusbarHeight + barHeight) / 2),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  const MainPage().getRoute(),
                );
              },
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const BugsListPage().getRoute(),
                    );
                  },
                  icon: const Icon(Icons.bug_report),
                  tooltip: baseConfig.localeStr("appbar.bug_hint"),
                  padding: verySmallDevice
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(8),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const DonatersPage().getRoute(),
                    );
                  },
                  icon: const Icon(Icons.savings),
                  tooltip: baseConfig.localeStr("appbar.donate_hint"),
                  padding: verySmallDevice
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(8),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const DownloadPage().getRoute(),
                    );
                  },
                  icon: const Icon(Icons.system_update),
                  tooltip: baseConfig.localeStr("appbar.download_hint"),
                  padding: verySmallDevice
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(8),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const NotesPage().getRoute(),
                    );
                  },
                  icon: const Icon(Icons.description),
                  tooltip: baseConfig.localeStr("appbar.notes_hint"),
                  padding: verySmallDevice
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(8),
                ),
                SizedBox(
                  width: verySmallDevice ? 5 : 10,
                ),
                LanguageSelector(size: (statusbarHeight + barHeight) / 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
