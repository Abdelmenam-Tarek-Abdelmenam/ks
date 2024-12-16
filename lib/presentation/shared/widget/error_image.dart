import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage(this.url,
      {this.width, this.height, this.fit = BoxFit.cover, super.key});
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        width: 15,
        height: 15,
        child: SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(
              Icons.downloading,
              size: 30,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(
            Icons.error,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class Base64Image extends StatelessWidget {
  const Base64Image(this.base64,
      {this.width, this.height, this.fit = BoxFit.cover, super.key});
  final String base64;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageConvert(),
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (_, err, __) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(
            Icons.error,
            size: 30,
          ),
        ),
      ),
    );
  }

  Uint8List imageConvert() {
    final String base64String = base64.split(',').last.trim().replaceAll('\n', '');
    Uint8List imageBytes = base64Decode(base64String);
    return imageBytes;
  }
}

String getMimeTypeFromPath(String filePath) {
  final extension = filePath.split('.').last.toLowerCase();
  switch (extension) {
    case 'png':
      return 'image/png';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'gif':
      return 'image/gif';
    case 'bmp':
      return 'image/bmp';
    case 'webp':
      return 'image/webp';
    default:
      throw UnsupportedError('Unsupported file extension: $extension');
  }
}

String convertImageToBase64(File imageFile) {
  Uint8List imageBytes =  imageFile.readAsBytesSync();
  String mimeType = getMimeTypeFromPath(imageFile.path);
  String base64String = base64Encode(imageBytes);

  return 'data:$mimeType;base64,$base64String';
}
