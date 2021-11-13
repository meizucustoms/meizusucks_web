import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';

// Big icon with text title amd text (and note)
class IconTextDownloadWidget extends StatelessWidget {
  const IconTextDownloadWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  final LatestReleaseInfo info;

  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);

    IconData icon = Icons.archive;
    EdgeInsetsGeometry padding = EdgeInsets.only(
      top: q.size.height / 16,
      left: q.size.width / (q.textScaleFactor * 8),
      right: q.size.width / (q.textScaleFactor * 8),
    );

    if (q.size.width > 700) {
      return Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: q.size.width / 8),
            SizedBox(
              width: (25 / q.textScaleFactor) * q.devicePixelRatio,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: baseConfig.localeStr("download.id") + ": ",
                        ),
                        TextSpan(
                          text: info.id,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24 * q.textScaleFactor),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: baseConfig.localeStr("download.size") + ": ",
                        ),
                        TextSpan(
                          text: (info.size / 1000 / 1000).toStringAsFixed(1) +
                              "MB",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24 * q.textScaleFactor),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: baseConfig.localeStr("download.version") + ": ",
                        ),
                        TextSpan(
                          text: info.version,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24 * q.textScaleFactor),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: baseConfig.localeStr("download.date") + ": ",
                        ),
                        TextSpan(
                          text: dateTimeToString(info.releaseDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24 * q.textScaleFactor),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "aboba",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * q.textScaleFactor),
              maxLines: 50,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }
}
