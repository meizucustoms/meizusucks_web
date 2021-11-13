import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meizusucks_web/src/common/common.dart';
import 'package:meizusucks_web/src/common/config.dart';

class Loader extends MzStatefulWidget {
  const Loader({Key? key, required this.route}) : super(key: key);

  @override
  String getRoute() => "/";

  final String route;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  late Future<bool> _initialization;

  Future<bool> init() async {
    bool ret;

    if (baseConfig.inited) {
      return true;
    }

    ret = await baseConfig.init();
    if (!ret) {
      return false;
    }

    ret = await sessionConfig.init();
    if (!ret) {
      return false;
    }

    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyA-JCfkJ78m1mlPNhg8hkq1BJa9amPc31o",
          authDomain: "meizuweb-901e1.firebaseapp.com",
          projectId: "meizuweb-901e1",
          storageBucket: "meizuweb-901e1.appspot.com",
          messagingSenderId: "664561336632",
          appId: "1:664561336632:web:82847f212dcebb1540c1cd",
          measurementId: "G-L4YL7W23FX",
        ),
      );
    } catch (e) {
      ret = false;
    }

    return ret;
  }

  @override
  void initState() {
    _initialization = init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.data == false) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  Text(
                    "Failed to load configuration. Maybe website is under maintenance.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.data == true) {
          if (widget.route != "/") {
            WidgetsBinding.instance!.addPostFrameCallback(
              (timeStamp) => Navigator.pushReplacementNamed(
                context,
                widget.route,
              ),
            );
          } else {
            WidgetsBinding.instance!.addPostFrameCallback(
              (timeStamp) => Navigator.pushReplacementNamed(
                context,
                "/main",
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                  Text(
                    "Configuration loaded, please wait...",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Loading configuration..."),
              ],
            ),
          ),
        );
      },
      future: _initialization,
    );
  }
}
