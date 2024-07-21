// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:masjidkorea/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final WebViewController _controller;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.masjidkorea.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://cendekiamuslim.or.id/adab-di-masjid-membangun-keharmonisan-dalam-tempat-ibadah'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: blackTextStyle.copyWith(fontSize: 24),
        title: const Text('Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
            },
            icon: Icon(
              isBookmarked ? Icons.bookmark_added : Icons.bookmark_add,
            ),
          ),
        ],
        backgroundColor: whiteColor,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
