import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/colors.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/widgets/appbar.dart';
import 'package:meizusucks_web/src/widgets/button.dart';
import 'package:meizusucks_web/src/widgets/footer.dart';
import 'package:meizusucks_web/src/widgets/textfield.dart';

class BugsReportPage extends MzStatefulWidget {
  const BugsReportPage({Key? key}) : super(key: key);

  @override
  String getRoute() => "/bugs_report";

  @override
  _BugsReportPageState createState() => _BugsReportPageState();
}

class _BugsReportPageState extends State<BugsReportPage> {
  late TextEditingController _tgController,
      _descController,
      _stepsController,
      _addonsController;
  Uint8List? _logcatOrPstore;
  String? _logcatOrPstoreFilename;

  bool _canBeSent = false;

  void _attachFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt', 'log']);
    if (result == null) {
      return;
    }

    if (result.files.first.bytes != null) {
      _logcatOrPstore = result.files.first.bytes;
      _canBeSentCheck();
      setState(() {
        _logcatOrPstoreFilename = result.files.first.name;
      });
    }
  }

  void _sendReport() async {
    Map<String, dynamic> json = {
      "telegram": _tgController.text,
      "bug": <String, dynamic>{
        "description": _descController.text,
        "steps_to_reproduce": _stepsController.text,
        "addons": _addonsController.text,
      }
    };

    String fire = jsonEncode(json);
    String firePath =
        "bugreports/${(DateTime.now().millisecondsSinceEpoch ~/ 1000).toStringAsFixed(0)}/";

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(firePath + "info.json")
        .putData(Uint8List.fromList(utf8.encode(fire)));
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(firePath + "log.txt")
        .putData(_logcatOrPstore!);

    setState(() {
      _tgController.text = "@";
      _stepsController.text = "";
      _descController.text = "";
      _addonsController.text = "";
      _logcatOrPstore = null;
      _logcatOrPstoreFilename = null;
      _canBeSent = false;
    });

    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.done),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      baseConfig.localeStr("report.sent"),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 20,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green),
        );
      },
    );
  }

  void _canBeSentCheck() {
    if ((_tgController.text != "@" || _tgController.text.isNotEmpty) &&
        _descController.text.length > 50 &&
        _stepsController.text.length > 50 &&
        _addonsController.text.isNotEmpty &&
        _logcatOrPstore != null) {
      if (_canBeSent != true) {
        setState(() {
          _canBeSent = true;
        });
      }
    } else {
      if (_canBeSent != false) {
        setState(() {
          _canBeSent = false;
        });
      }
    }
  }

  @override
  void initState() {
    _tgController = TextEditingController(text: "@")
      ..addListener(_canBeSentCheck);
    _descController = TextEditingController()..addListener(_canBeSentCheck);
    _stepsController = TextEditingController()..addListener(_canBeSentCheck);
    _addonsController = TextEditingController()..addListener(_canBeSentCheck);
    super.initState();
  }

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
                    baseConfig.localeStr("report.title"),
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
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: baseConfig.localeStr("report.tgname"),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: textInputRequiredC),
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzTextField(
                  controller: _tgController,
                  big: false,
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: baseConfig.localeStr("report.bug_description"),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: textInputRequiredC),
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzTextField(
                  controller: _descController,
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: baseConfig.localeStr("report.steps"),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: textInputRequiredC),
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzTextField(
                  controller: _stepsController,
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: baseConfig.localeStr("report.addons_title"),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: textInputRequiredC),
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("report.addons_note"),
                    style: TextStyle(
                      fontSize: (18 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzTextField(
                  controller: _addonsController,
                ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: baseConfig.localeStr("report.log_title"),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: textInputRequiredC),
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  text: _logcatOrPstoreFilename ??
                      baseConfig.localeStr("report.log_file"),
                  icon: Icons.attach_file,
                  onPressed: _attachFile,
                  color:
                      (_logcatOrPstore != null) ? blueButtonsC : greyButtonsC,
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                ),
                if (_logcatOrPstore != null)
                  SizedBox(
                    height: q.size.height / 64,
                  ),
                if (_logcatOrPstore != null)
                  MzButton(
                    text: baseConfig.localeStr("report.log_remove"),
                    icon: Icons.delete_forever,
                    onPressed: () {
                      setState(() {
                        _logcatOrPstore = null;
                        _logcatOrPstoreFilename = null;
                      });
                    },
                    color: greyButtonsC,
                    width: q.size.width < 700
                        ? q.size.width / 1.2
                        : q.size.width / 4,
                  ),
                SizedBox(
                  height: q.size.height / 32,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("report.final"),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  text: baseConfig.localeStr("report.submit"),
                  icon: Icons.done,
                  onPressed: _canBeSent ? _sendReport : null,
                  color: _canBeSent ? blueButtonsC : greyButtonsC,
                  width: q.size.width < 700
                      ? q.size.width / 1.2
                      : q.size.width / 4,
                ),
                SizedBox(
                  height: q.size.height / 16,
                ),
                Center(
                  child: Text(
                    baseConfig.localeStr("report.dima_mode"),
                    style: TextStyle(
                      fontSize: (24 * q.textScaleFactor) / smallDeviceRadio,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: q.size.height / 64,
                ),
                MzButton(
                  text: baseConfig.localeStr("report.bugs"),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/bugs_list");
                  },
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
