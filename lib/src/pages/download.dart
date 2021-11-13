import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/widgets/appbar.dart';
import 'package:meizusucks_web/src/widgets/button.dart';
import 'package:meizusucks_web/src/widgets/footer.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:meizusucks_web/src/widgets/icontext_download.dart';

class DownloadPage extends MzStatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  String getRoute() => "/download";

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);
    final double smallDeviceRadio = (q.size.width < 500) ? 1.5 : 1;

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
                SizedBox(
                  height: q.size.height / 8,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("download.title"),
                    style: TextStyle(
                      fontSize: (48 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                IconTextDownloadWidget(info: baseConfig.main!.latest),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  onPressed: () {
                    debugLog(baseConfig.main!.latest.downloadUri.toString());
                    js.context.callMethod(
                      'open',
                      [baseConfig.main!.latest.downloadUri.toString()],
                    );
                  },
                  icon: Icons.system_update,
                  text: baseConfig.localeStr("download.download"),
                  color: blueButtonsC,
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("download.notes"),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    baseConfig.main!
                        .getReleaseNotes(baseConfig.main!.latest.id),
                    style: TextStyle(
                      fontSize: (18 * q.textScaleFactor),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 20,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
