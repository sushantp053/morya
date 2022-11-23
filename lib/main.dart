import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:morya/about_us.dart';
import 'package:morya/privacy_policy.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Morya'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: Colors.orange),
              currentAccountPicture: Image(
                image: AssetImage(
                  'images/ic_launcher.png',
                ),
              ),
              accountName: Text(
                "Morya Matrimonial",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              accountEmail: Text(
                "moryamatrimonial24@gmail.com",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            ListTile(
              title: const Text('Share App'),
              leading: const Icon(Icons.share),
              onTap: () {
                Get.back();
                share();
              },
            ),
            ListTile(
              title: const Text('Rate App'),
              leading: const Icon(Icons.star),
              onTap: () {
                inAppReview.openStoreListing(appStoreId: "com.moryamatrimonial.morya");
              },
            ),
            ListTile(
              title: const Text('About Us'),
              leading: const Icon(Icons.person),
              onTap: () {
                Get.back();
                Get.to(const AboutUs());
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              leading: const Icon(Icons.privacy_tip),
              onTap: () {
                Get.back();
                Get.to(const Privacy());
              },
            ),
            ListTile(
              title: const Text('Exit'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                // Update the state of the app.
                // ...
                Get.defaultDialog(
                  middleText: "Do you really want to exit ?",
                  title: "Exiting from app.",
                  actions: [
                    TextButton(
                        child: const Text("Exit"),
                        onPressed: () {
                          SystemNavigator.pop();

                        }),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const WebView(
        initialUrl: 'https://www.moryamatrimonial.com/',
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Morya Matrimonial App',
        text: 'Share our app with your friend and family',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.moryamatrimonial.morya',
        chooserTitle: 'Share App');
  }

}
