import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project1/nav/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

// open sceen webview
class ArticleViews extends StatefulWidget {

  final String blogUrl;
  const ArticleViews({required this.blogUrl});

  @override
  _ArticleViewsState createState() => _ArticleViewsState();
}

class _ArticleViewsState extends State<ArticleViews> {

  final Completer<WebViewController> _completer =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subAppBar("Have a good day!"),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
