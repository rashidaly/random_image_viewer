import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ColorExtractorService {
  Future<Color> extractDominantColor(String imageUrl) async {
    try {
      final provider = CachedNetworkImageProvider(imageUrl);

      final palette = await PaletteGenerator.fromImageProvider(
        provider,
        maximumColorCount: 20,
      );

      return palette.dominantColor?.color ??
          palette.vibrantColor?.color ??
          palette.mutedColor?.color ??
          Colors.grey.shade300;
    } catch (_) {
      return Colors.grey.shade300;
    }
  }
}
