import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/widgets/appbar.dart';
import 'package:meizusucks_web/src/widgets/button.dart';
import 'package:meizusucks_web/src/widgets/footer.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class DonatersPage extends MzStatefulWidget {
  const DonatersPage({Key? key}) : super(key: key);

  @override
  String getRoute() => "/donate";

  @override
  _DonatersPageState createState() => _DonatersPageState();
}

class _DonatersPageState extends State<DonatersPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);
    final double smallDeviceRadio = (q.size.width < 500) ? 1.5 : 1;

    List<Widget> _donaterWidgets = [];

    for (var i in baseConfig.main!.donaters) {
      _donaterWidgets.addAll([
        SizedBox(
          height: q.size.height / 128,
        ),
        Center(
          child: Text(
            i,
            style: TextStyle(
              fontSize: (18 * q.textScaleFactor) / smallDeviceRadio,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    }

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
                    baseConfig.localeStr("donate.title"),
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
                MzButton(
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  onPressed: () {
                    js.context
                        .callMethod('open', ['https://ko-fi.com/meizucustoms']);
                  },
                  text: baseConfig.localeStr("donate.kofi"),
                  color: greyButtonsC,
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                  onPressed: () {
                    js.context.callMethod('open', ['https://paypal.me/tdrk']);
                  },
                  text: baseConfig.localeStr("donate.paypal"),
                  color: greyButtonsC,
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("donate.already_donated"),
                    style: TextStyle(
                      fontSize: (36 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: _donaterWidgets,
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
