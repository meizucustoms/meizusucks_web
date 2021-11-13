import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';

class MzTextField extends StatefulWidget {
  const MzTextField({
    Key? key,
    required this.controller,
    this.initialValue,
    this.big = true,
  }) : super(key: key);

  final String? initialValue;
  final TextEditingController controller;
  final bool big;

  @override
  _MzTextFieldState createState() => _MzTextFieldState();
}

class _MzTextFieldState extends State<MzTextField> {
  late FocusNode _focus;

  @override
  void initState() {
    _focus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData q = MediaQuery.of(context);

    return Align(
      child: SizedBox(
        width: widget.big
            ? q.size.width / 1.4
            : q.size.width < 500
                ? q.size.width / 1.4
                : q.size.width / 4,
        child: TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          focusNode: _focus,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: textFieldStrokeC,
                width: 4 * MediaQuery.of(context).devicePixelRatio,
              ),
            ),
            fillColor: textFieldBackgroundC,
            filled: true,
          ),
          maxLines: widget.big ? 10 : 1,
        ),
      ),
    );
  }
}
