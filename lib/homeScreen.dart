import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController webController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WillPopScope(
        onWillPop:() async {
          if(await webController.canGoBack() ){
            webController.goBack();
            return false;
          }else{
            return true;
          }
        },
        child: Column(
          children: [
            progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    valueColor: const AlwaysStoppedAnimation(Colors.pink),
                  )
                : const Center(),
            Expanded(
                child: InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse("https://evobazarbd.com/"),),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(javaScriptEnabled: true,
                        javaScriptCanOpenWindowsAutomatically: true
                      )),
                  onProgressChanged: (controller, load) => setState(() {
                    progress = load /100;
                  }),
                  onWebViewCreated: (controller) => webController = controller,
            ))
          ],
        ),
      ),
    ));
  }
}
