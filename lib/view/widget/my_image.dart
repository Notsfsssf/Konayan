import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class MyImage extends StatelessWidget {
  final String url;

  MyImage(this.url, this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: NetworkLImage(url, onPressed));
  }
}

class NetworkLImage extends ImageProvider<NetworkLImage> {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments must not be null.
  const NetworkLImage(this.url, this.onPressed,
      {this.scale = 1.0, this.headers})
      : assert(url != null),
        assert(scale != null);
  final VoidCallback onPressed;

  /// The URL from which the image will be fetched.
  final String url;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  final Map<String, String> headers;

  @override
  Future<NetworkLImage> obtainKey(ImageConfiguration configuration) {
    print("load");
    return SynchronousFuture<NetworkLImage>(this);
  }

  @override
  ImageStreamCompleter load(NetworkLImage key) {
    return MultiFrameImageStreamCompleter(
        codec: _loadAsync(key),
        scale: key.scale,
        informationCollector: (StringBuffer information) {
          information.writeln('Image provider: $this');
          information.write('Image key: $key');
        });
  }

  static final HttpClient _httpClient = HttpClient();

  Future<Codec> _loadAsync(NetworkLImage key) async {
    assert(key == this);

    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    headers?.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok)
      throw Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}, $resolved');

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0)
      throw Exception('NetworkLImage is an empty file: $resolved');
    this.onPressed();
    return PaintingBinding.instance.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final NetworkLImage typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
