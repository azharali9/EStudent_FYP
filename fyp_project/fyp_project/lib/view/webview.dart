import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class web2 extends StatefulWidget {
  const web2({Key? key}) : super(key: key);

  @override
  State<web2> createState() => _web2State();
}

class _web2State extends State<web2> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late final String initialUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialUrl = 'https://time-table-generator-q6o8p9ciz-mudassirw165.vercel.app';
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController?.reload();
      },
      options: PullToRefreshOptions(
        color: Colors.white,
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
              onWebViewCreated: (controller) {
                webViewController = controller;
                controller
                    .loadUrl(urlRequest: URLRequest(url: Uri.parse(initialUrl)))
                    .then((_) {
                  setState(() {
                    isLoading = false;
                  }
                  );
                });
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (controller, url) {
                refreshController?.endRefreshing();
                setState(() {
                  isLoading = false;
                });
              },
              pullToRefreshController: refreshController,
            ),
            Visibility(
              visible: isLoading,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}