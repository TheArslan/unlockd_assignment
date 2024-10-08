import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Custom Network image view for global use
class NetworkImageView extends StatelessWidget {
  final String? _imageUrl;
  final BoxFit fit;
  final String? placeHolder;
  const NetworkImageView(
    this._imageUrl, {
    super.key,
    this.fit = BoxFit.cover,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return (_imageUrl == null || _imageUrl.isEmpty)
        ? _buildErrorView()
        : CachedNetworkImage(
            imageUrl: _imageUrl,
            fit: fit,
            placeholder: (_, __) => placeHolder != null
                ? NetworkImageView(
                    placeHolder,
                    fit: fit,
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade500,
                    child: const ColoredBox(color: Colors.black),
                  ),
            maxHeightDiskCache: screenSize.height.toInt() * 2,
            maxWidthDiskCache: screenSize.width.toInt() * 2,
            errorWidget: (_, __, ___) => _buildErrorView(),
          );
  }

  Widget _buildErrorView() => const Icon(
        Icons.image,
        size: 45,
      );
}
