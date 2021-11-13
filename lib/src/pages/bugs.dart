import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/pages/report.dart';
import 'package:meizusucks_web/src/widgets/appbar.dart';
import 'package:meizusucks_web/src/widgets/button.dart';
import 'package:meizusucks_web/src/widgets/footer.dart';

class BugsListPage extends MzStatefulWidget {
  const BugsListPage({Key? key}) : super(key: key);

  @override
  String getRoute() => "/bugs_list";

  @override
  _BugsListPageState createState() => _BugsListPageState();
}

class _BugsListPageState extends State<BugsListPage> {
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
                    baseConfig.localeStr("bugs.title"),
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
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: baseConfig.localeStr("bugs.id") + ": ",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(text: baseConfig.main!.latest.id),
                    ]),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text(
                    baseConfig.main!.getReleaseBugs(baseConfig.main!.latest.id),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 20,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("bugs.not_listed"),
                    style: TextStyle(
                      fontSize: (36 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      const BugsReportPage().getRoute(),
                    );
                  },
                  text: baseConfig.localeStr("bugs.create"),
                  color: greyButtonsC,
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
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
