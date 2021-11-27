import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';
import 'package:meizusucks_web/src/pages/bugs.dart';
import 'package:meizusucks_web/src/pages/donaters.dart';
import 'package:meizusucks_web/src/pages/download.dart';
import 'package:meizusucks_web/src/pages/loader.dart';
import 'package:meizusucks_web/src/pages/notes.dart';
import 'package:meizusucks_web/src/pages/report.dart';
import 'package:meizusucks_web/src/pages/root.dart';

void main() {
  setUrlStrategy(const HashUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      // Apply Poppins font
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: "Poppins"),
      ),
      onGenerateRoute: (settings) {
        List<MzStatefulWidget> widgets = const [
          MainPage(),
          BugsListPage(),
          BugsReportPage(),
          NotesPage(),
          DonatersPage(),
          DownloadPage(),
        ];

        if (!baseConfig.inited) {
          String loaderRoute = settings.name ?? "/";

          if (loaderRoute == "/") {
            loaderRoute = "/main";
          }

          return MaterialPageRoute(
            builder: (context) => Loader(
              route: loaderRoute,
            ),
            settings: settings,
          );
        }

        for (var i in widgets) {
          if (i.getRoute() == settings.name) {
            return MaterialPageRoute(
              builder: (context) => i,
              settings: settings,
            );
          }
        }

        return MaterialPageRoute(
          builder: (context) => const MainPage(),
          settings: settings,
        );
      },
      title: "MeizuSucks",
    ),
  );
}
