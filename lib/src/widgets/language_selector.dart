import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/config.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (lang) {
        sessionConfig.language = lang;
        Navigator.of(context).pushReplacementNamed(
          "/main",
        );
      },
      itemBuilder: (context) {
        List<PopupMenuEntry<String>> ret = [];

        for (var i in supportedLanguages) {
          ret.add(
            PopupMenuItem<String>(
              value: i,
              child: Text(
                i.toUpperCase(),
              ),
            ),
          );
        }

        return ret;
      },
      child: Container(
        decoration: BoxDecoration(
          color: languageSelectorBackgroundC,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.only(
          left: widget.size / 5,
          right: widget.size / 5,
          top: widget.size / 15,
          bottom: widget.size / 15,
        ),
        child: Row(
          children: [
            Text(
              sessionConfig.language.toUpperCase(),
              style: TextStyle(fontSize: widget.size / 1.2),
            ),
            SizedBox(
              width: widget.size / 8,
            ),
            const Icon(
              Icons.language,
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
    );
  }
}
