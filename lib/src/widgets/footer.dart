import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/widgets/button.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);
    TapGestureRecognizer copyrightUriGesture = TapGestureRecognizer()
      ..onTap = () {
        js.context.callMethod(
            'open', ['https://github.com/meizucustoms/meizusucks_web']);
      };

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          SizedBox(
            height: q.size.height / 5,
          ),
          Text(
            baseConfig.localeStr("footer.links"),
            style: TextStyle(
              fontSize: 24 * q.textScaleFactor,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: q.size.height / 64,
          ),
          if (q.size.width > 500)
            Row(
              children: [
                MzButton(
                  width: q.size.width / 4,
                  onPressed: () {
                    js.context.callMethod('open', ['https://t.me/msucks']);
                  },
                  text: baseConfig.localeStr("footer.tgchannel"),
                  color: greyButtonsC,
                ),
                MzButton(
                  width: q.size.width / 4,
                  onPressed: () {
                    js.context.callMethod('open', ['https://t.me/msucks_chat']);
                  },
                  text: baseConfig.localeStr("footer.tgchat"),
                  color: greyButtonsC,
                ),
                MzButton(
                  width: q.size.width / 4,
                  onPressed: () {
                    js.context.callMethod(
                        'open', ['https://github.com/meizucustoms']);
                  },
                  text: baseConfig.localeStr("footer.github"),
                  color: greyButtonsC,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          if (q.size.width < 500)
            Column(
              children: [
                MzButton(
                  width: q.size.width / 1.2,
                  onPressed: () {
                    js.context.callMethod('open', ['https://t.me/msucks']);
                  },
                  text: baseConfig.localeStr("footer.tgchannel"),
                  color: greyButtonsC,
                ),
                SizedBox(height: q.size.height / 64),
                MzButton(
                  width: q.size.width / 1.2,
                  onPressed: () {
                    js.context.callMethod('open', ['https://t.me/msucks_chat']);
                  },
                  text: baseConfig.localeStr("footer.tgchat"),
                  color: greyButtonsC,
                ),
                SizedBox(height: q.size.height / 64),
                MzButton(
                  width: q.size.width / 1.2,
                  onPressed: () {
                    js.context.callMethod(
                        'open', ['https://github.com/meizucustoms']);
                  },
                  text: baseConfig.localeStr("footer.github"),
                  color: greyButtonsC,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          SizedBox(
            height: q.size.height / 64,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: q.size.width / 16,
              right: q.size.width / 16,
            ),
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: baseConfig.localeStr("footer.copyright") + " ",
                ),
                TextSpan(
                  text: "https://github.com/meizucustoms/meizusucks_web",
                  recognizer: copyrightUriGesture,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ]),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18 * q.textScaleFactor,
                color: footerCopyrightC,
              ),
              maxLines: 50,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: q.size.height / 64,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
