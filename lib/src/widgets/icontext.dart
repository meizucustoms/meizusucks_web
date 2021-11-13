import 'package:flutter/material.dart';

enum IconTextWidgetSide {
  left,
  right,
}

// Big icon with text title amd text (and note)
class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.text,
    required this.padding,
    required this.side,
    this.button,
    this.note,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String text;
  final EdgeInsetsGeometry padding;
  final IconTextWidgetSide side;
  final String? note;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);
    TextAlign textAlign =
        side == IconTextWidgetSide.left ? TextAlign.left : TextAlign.right;
    CrossAxisAlignment cross = side == IconTextWidgetSide.left
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.end;
    MainAxisAlignment main = side == IconTextWidgetSide.left
        ? MainAxisAlignment.start
        : MainAxisAlignment.end;

    if (q.size.width > 700) {
      return Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: main,
          children: [
            if (side == IconTextWidgetSide.left)
              Icon(icon, size: q.size.width / 8),
            if (side == IconTextWidgetSide.left)
              SizedBox(
                width: (25 / q.textScaleFactor) * q.devicePixelRatio,
              ),
            Flexible(
              child: Column(
                crossAxisAlignment: cross,
                mainAxisAlignment: main,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36 * q.textScaleFactor),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: textAlign,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24 * q.textScaleFactor),
                    maxLines: 50,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: textAlign,
                  ),
                  if (note != null)
                    Text(
                      note!,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18 * q.textScaleFactor,
                          color: Colors.grey),
                      maxLines: 50,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: textAlign,
                    ),
                  if (button != null) const SizedBox(height: 10),
                  if (button != null)
                    Row(
                      mainAxisAlignment: main,
                      children: [
                        button!,
                      ],
                    )
                ],
              ),
            ),
            if (side == IconTextWidgetSide.right)
              SizedBox(
                width: (25 / q.textScaleFactor) * q.devicePixelRatio,
              ),
            if (side == IconTextWidgetSide.right)
              Icon(icon, size: q.size.width / 8),
          ],
        ),
      );
    } else {
      return Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24 * q.textScaleFactor),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * q.textScaleFactor),
              maxLines: 50,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            if (note != null)
              Text(
                note!,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 10 * q.textScaleFactor,
                    color: Colors.grey),
                maxLines: 50,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            if (button != null) const SizedBox(height: 10),
            if (button != null) button!,
          ],
        ),
      );
    }
  }
}
