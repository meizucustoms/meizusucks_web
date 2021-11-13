import 'package:flutter/material.dart';

class MzButton extends StatelessWidget {
  const MzButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.width,
    this.icon,
    this.size,
    this.minSize = true,
  }) : super(key: key);

  final Color color;
  final String text;
  final IconData? icon;
  final double? size;
  final double? width;
  final Function()? onPressed;
  final bool minSize;

  @override
  Widget build(BuildContext context) {
    double _size = 0;

    if (size == null) {
      _size = MediaQuery.of(context).textScaleFactor * 18;
    } else {
      _size = size!;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: _size,
                  ),
                if (icon != null)
                  const SizedBox(
                    width: 10,
                  ),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: _size),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
