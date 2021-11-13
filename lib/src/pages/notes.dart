import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/widgets/appbar.dart';
import 'package:meizusucks_web/src/widgets/footer.dart';

class NotesPage extends MzStatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  String getRoute() => "/notes";

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);
    final double smallDeviceRadio = (q.size.width < 500) ? 1.5 : 1;

    List<Widget> _notesWidgets = [];

    for (var i in baseConfig.main!.release) {
      _notesWidgets.addAll([
        SizedBox(
          height: q.size.height / 32,
        ),
        Center(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: baseConfig.localeStr("bugs.id") + ": ",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(text: i.id),
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
        Center(
          child: Text(
            baseConfig.main!.getReleaseNotes(i.id),
            style: TextStyle(
              fontSize: (18 * q.textScaleFactor) / smallDeviceRadio,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 10,
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
                    baseConfig.localeStr("notes.notes"),
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
                Column(
                  children: _notesWidgets,
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
