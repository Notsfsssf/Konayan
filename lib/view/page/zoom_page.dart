import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ZoomPage  extends StatefulWidget {
  final String url;
  ZoomPage(this.url);
  @override
  _ZoomPageState createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: PhotoView(
        imageProvider: CachedNetworkImageProvider(widget.url),
    ),
    );
  }
}
