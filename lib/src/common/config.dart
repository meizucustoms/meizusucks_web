import 'dart:core';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Base link for data files
String dataLink =
    "https://raw.githubusercontent.com/meizucustoms/meizusucks_web_data/master/";

String configFile = "info";
List<String> supportedLanguages = [
  "en",
  "ru",
  "ua",
  "cn",
  "by",
  "sk",
];

String losUri =
    "https://raw.githubusercontent.com/meizucustoms/OTAUpdates/master/m1721.json";

String getDataUri(String file) {
  return dataLink + file + ".json";
}

// ROM package info
// Note:
// Size and other info is provided by
// checking LOS Updater JSON, and used
// only for latest package.
class ReleaseInfo {
  late String id;
  late List<String> bugs;
  late List<String> notes;

  ReleaseInfo({
    required this.id,
    required this.bugs,
    required this.notes,
  });

  ReleaseInfo.fromJson(Map<String, dynamic> object) {
    // Check all types
    if (object["id"] == null || object["id"].runtimeType != String) {
      throw ("releaseinfo: invalid id");
    }

    if (object["bugs"] == null) {
      throw ("releaseinfo: invalid bugs");
    }

    if (object["notes"] == null) {
      throw ("releaseinfo: invalid notes");
    }

    // Assign values
    id = object["id"];
    bugs = List<String>.from(object["bugs"]);
    notes = List<String>.from(object["notes"]);
  }
}

// Latest ROM package info
// Provided by checking LOS Updater JSON
class LatestReleaseInfo {
  late String id;
  late DateTime releaseDate;
  late String md5;
  late int size;
  late String version;
  late Uri downloadUri;

  LatestReleaseInfo({
    required this.id,
    required this.releaseDate,
    required this.md5,
    required this.size,
    required this.version,
    required this.downloadUri,
  });

  LatestReleaseInfo.fromJson(Map<String, dynamic> config) {
    // Data is located under response[0]
    if (config["response"][0] == null) {
      throw ("lri: invalid response[0]");
    }

    Map<String, dynamic> object = config["response"][0];

    // Check all types
    if (object["datetime"] == null ||
        object["datetime"].runtimeType != String) {
      throw ("lriobj: invalid datetime");
    }

    if (object["id"] == null || object["id"].runtimeType != String) {
      throw ("lriobj: invalid id");
    }

    if (object["size"] == null || object["size"].runtimeType != String) {
      throw ("lriobj: invalid size");
    }

    if (object["url"] == null || object["url"].runtimeType != String) {
      throw ("lriobj: invalid url");
    }

    if (object["version"] == null || object["version"].runtimeType != String) {
      throw ("lriobj: invalid version");
    }

    // Assign values
    String url = object["url"];

    md5 = object["id"];
    releaseDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(object["datetime"]) * 1000);
    size = int.parse(object["size"]);
    downloadUri = Uri.parse(object["url"]);
    version = object["version"];
    id = url // Release tag is located in download URL
        .replaceAll(
            "https://github.com/meizucustoms/OTAUpdates/releases/download/", "")
        .replaceAll(RegExp(r"/.*"), "");
  }
}

class BaseConfigMain {
  late List<ReleaseInfo> release;
  late LatestReleaseInfo latest;
  late List<String> donaters;

  BaseConfigMain({
    required this.release,
    required this.latest,
    required this.donaters,
  });

  ReleaseInfo? getRelease(String id) {
    ReleaseInfo? ret;

    for (var i in release) {
      if (i.id == id) {
        ret = i;
      }
    }

    return ret;
  }

  String getReleaseBugs(String id) {
    ReleaseInfo? info = getRelease(id);
    if (info == null) {
      return "Not known yet";
    }

    return info.bugs.join("\n");
  }

  String getReleaseNotes(String id) {
    ReleaseInfo? info = getRelease(id);
    if (info == null) {
      return "Not known yet";
    }

    return info.notes.join("\n");
  }

  BaseConfigMain.fromJson(
      Map<String, dynamic> config, Map<String, dynamic> latest) {
    // Check types
    if (config["releases_info"] == null) {
      throw ("mainconfig: invalid releases_info");
    }

    if (config["donaters"] == null) {
      throw ("mainconfig: invalid donaters");
    }

    // Assign values
    donaters = List<String>.from(config["donaters"]);
    release = [];
    for (var i in config["releases_info"]) {
      release.add(ReleaseInfo.fromJson(i));
    }
    this.latest = LatestReleaseInfo.fromJson(latest);
  }
}

Future<Map<String, dynamic>?> getWebConfig(String file,
    {bool fullUri = false}) async {
  Response<String>? mainConfig;

  debugLog("Loading config ${fullUri ? file : getDataUri(file)}");

  try {
    mainConfig = await Dio().get(fullUri ? file : getDataUri(file));
    // workaround to do not throw error to init()
    // ignore: empty_catches
  } catch (e) {
    debugLog("URI: ${fullUri ? file : getDataUri(file)}");
    debugLog(e.toString());
  }

  if (mainConfig == null || mainConfig.data == null) {
    return null;
  }

  return jsonDecode(mainConfig.data!);
}

// Online configuration
class BaseConfig {
  BaseConfigMain? main;
  late Map<String, Map<String, dynamic>> _locale;
  String nonCriticalErrors = "";
  bool inited = false;

  void _writeToErrors(String error) {
    if (nonCriticalErrors.isEmpty) {
      nonCriticalErrors = error;
    } else {
      nonCriticalErrors = nonCriticalErrors + "\n" + error;
    }
  }

  Future<bool> init() async {
    if (inited) {
      return true;
    }

    var mainConfig = await getWebConfig(configFile);
    if (mainConfig == null) {
      inited = true;
      return false;
    }

    var losConfig = await getWebConfig(losUri, fullUri: true);
    if (losConfig == null) {
      inited = true;
      return false;
    }

    try {
      main = BaseConfigMain.fromJson(mainConfig, losConfig);
    } catch (e) {
      debugLog("Configuration is invalid");
      debugLog(e.toString());

      inited = true;
    }

    if (inited) return false;

    _locale = {};

    for (var i in supportedLanguages) {
      var locale = await getWebConfig(i);
      if (locale == null) {
        _writeToErrors("Failed to load $i language");
        supportedLanguages.remove(i);
        continue;
      }

      _locale[i] = locale;
    }

    debugLog("Configuration loaded successfully");

    inited = true;
    return true;
  }

  String _localeStr(String language, String request) {
    List<String> objects = request.split(".");
    String? answer;

    if (objects.length == 1) {
      answer = _locale[language]![objects[0]];
    } else if (objects.length == 2) {
      answer = _locale[language]![objects[0]][objects[1]];
    } else if (objects.length == 3) {
      answer = _locale[language]![objects[0]][objects[1]][objects[2]];
    } else if (objects.length == 4) {
      answer =
          _locale[language]![objects[0]][objects[1]][objects[2]][objects[3]];
    }

    if (answer == null || answer.isEmpty) {
      answer = "error";
    }

    return answer;
  }

  String localeStr(String request) {
    String? answer;

    answer = _localeStr(sessionConfig.language, request);
    if (answer == "error") {
      // English is a fallback language if
      // localized string wasn't found
      answer = _localeStr("en", request);
    }

    return answer;
  }
}

// User-changed config
// Can be used for settings in future.
class SessionConfig {
  String? _language;
  bool inited = false;

  Future<bool> init() async {
    if (inited) {
      return true;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("language")) {
      prefs.setString("language", "en");
    }

    _language = prefs.getString("language");

    inited = true;
    return true;
  }

  String get language {
    return _language ?? "en";
  }

  set language(String val) {
    if (!supportedLanguages.contains(val)) {
      debugLog("Invalid language $val");
      return;
    }

    _language = val;
    _setPrefsLang(val);
  }

  void _setPrefsLang(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", val);
  }
}

// This config won't be changed after start
BaseConfig baseConfig = BaseConfig();
SessionConfig sessionConfig = SessionConfig();
