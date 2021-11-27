import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/pages/bugs.dart';
import 'package:meizusucks_web/src/pages/donaters.dart';
import 'package:meizusucks_web/src/pages/download.dart';
import 'package:meizusucks_web/src/pages/notes.dart';
import 'package:meizusucks_web/src/widgets/appbar.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/widgets/button.dart';
import 'package:meizusucks_web/src/widgets/footer.dart';
import 'package:meizusucks_web/src/widgets/icontext.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class MainPage extends MzStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  String getRoute() => "/main";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LinearGradient gradient = const LinearGradient(
    colors: [
      Colors.blueAccent,
      Colors.deepPurple,
    ],
  );

  @override
  void initState() {
    if (baseConfig.nonCriticalErrors.isNotEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        baseConfig.nonCriticalErrors,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 20,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red),
          );
        },
      );
      Future.delayed(
        const Duration(milliseconds: 10),
      ).then((value) => baseConfig.nonCriticalErrors = "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MzAppBar(
            screenWidth: q.size.width,
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: q.size.width / 16,
                    right: q.size.width / 16,
                    top: q.devicePixelRatio * 2,
                    bottom: q.devicePixelRatio * 2,
                  ),
                  width: q.size.width,
                  height: q.size.height / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        mainHeadGradLeftC,
                        mainHeadGradRightC,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: baseConfig
                                .localeStr("main.slogan_before_different"),
                          ),
                          TextSpan(
                            text: baseConfig.localeStr("main.slogan_different"),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: differentTextGradTopC,
                            ),
                          ),
                          TextSpan(
                            text: " " +
                                baseConfig
                                    .localeStr("main.slogan_after_different"),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 30 * q.textScaleFactor),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: (q.size.height / 2 - q.textScaleFactor * 4) ~/
                          (30 * q.textScaleFactor + 8 * q.devicePixelRatio),
                    ),
                  ),
                ),
                SizedBox(
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("main.features.title"),
                    style: TextStyle(
                      fontSize: 48 * q.textScaleFactor,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.lock_open,
                    title:
                        baseConfig.localeStr("main.features.opensource.title"),
                    text: baseConfig
                        .localeStr("main.features.opensource.description"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.left,
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.photo_camera,
                    title: baseConfig
                        .localeStr("main.features.better_photos.title"),
                    text: baseConfig
                        .localeStr("main.features.better_photos.description"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.right,
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.android,
                    title:
                        baseConfig.localeStr("main.features.new_android.title"),
                    text: baseConfig
                        .localeStr("main.features.new_android.description"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.left,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("main.links.title"),
                    style: TextStyle(
                      fontSize: 48 * q.textScaleFactor,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const BugsListPage().getRoute(),
                    );
                  },
                  text: baseConfig.localeStr("main.links.bugs"),
                  color: blueButtonsC,
                  icon: Icons.bug_report,
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const DonatersPage().getRoute(),
                    );
                  },
                  text: baseConfig.localeStr("main.links.donate"),
                  color: blueButtonsC,
                  icon: Icons.savings,
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const DownloadPage().getRoute(),
                    );
                  },
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  text: baseConfig.localeStr("main.links.download"),
                  color: blueButtonsC,
                  icon: Icons.system_update,
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const NotesPage().getRoute(),
                    );
                  },
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  text: baseConfig.localeStr("main.links.notes"),
                  color: blueButtonsC,
                  icon: Icons.description,
                ),
                SizedBox(
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("main.installation.title"),
                    style: TextStyle(
                      fontSize: 48 * q.textScaleFactor,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.construction,
                    title: baseConfig
                        .localeStr("main.installation.bootloader.title"),
                    text: baseConfig
                        .localeStr("main.installation.bootloader.description"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.right,
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.downloading,
                    title: baseConfig
                        .localeStr("main.installation.orangefox.title"),
                    text: baseConfig
                        .localeStr("main.installation.orangefox.description"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.left,
                    button: MzButton(
                      width: q.size.width < 700
                          ? q.size.width / 2
                          : q.size.width / 4,
                      color: Colors.blue,
                      text: baseConfig
                          .localeStr("main.installation.download_orangefox"),
                      onPressed: () {
                        js.context.callMethod('open',
                            ['https://orangefox.download/device/m1721']);
                      },
                    ),
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.network_cell,
                    title:
                        baseConfig.localeStr("main.installation.modem.title"),
                    text: baseConfig
                        .localeStr("main.installation.modem.description"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.right,
                    button: MzButton(
                      width: q.size.width < 700
                          ? q.size.width / 2
                          : q.size.width / 4,
                      color: Colors.blue,
                      text: baseConfig
                          .localeStr("main.installation.download_patch"),
                      onPressed: () {
                        js.context.callMethod('open', [
                          'https://drive.google.com/file/d/1GgCea_Phec9vqLNwffOApRl-RmEhElzl/view?usp=sharing'
                        ]);
                      },
                    ),
                  ),
                ),
                Center(
                  child: IconTextWidget(
                    icon: Icons.widgets,
                    title:
                        baseConfig.localeStr("main.installation.install.title"),
                    text: baseConfig
                        .localeStr("main.installation.install.description"),
                    note:
                        baseConfig.localeStr("main.installation.install.note"),
                    padding: EdgeInsets.only(
                      top: q.size.height / 16,
                      left: q.size.width / (q.textScaleFactor * 8),
                      right: q.size.width / (q.textScaleFactor * 8),
                    ),
                    side: IconTextWidgetSide.left,
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
