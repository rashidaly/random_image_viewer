import 'package:flutter/material.dart';

class ImageState {
  final String? imageUrl;
  final bool isLoading;
  final String? error;
  final Color backgroundColor;

  ImageState({
    this.imageUrl,
    this.isLoading = false,
    this.error,
    this.backgroundColor = const Color(0xFFEEEEEE),
  });

  ImageState copyWith({
    String? imageUrl,
    bool? isLoading,
    String? error,
    Color? backgroundColor,
  }) {
    return ImageState(
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
