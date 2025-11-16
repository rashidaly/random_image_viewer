import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_image_viewer/data/models/image_state.dart';

import '../../../data/repositories/image_repository.dart';
import '../../../data/services/color_extractor_service.dart';

class ImageViewModel extends StateNotifier<ImageState> {
  final ImageRepository _repository;
  final ColorExtractorService _colorService;

  ImageViewModel(this._repository, this._colorService) : super(ImageState()) {
    fetchImage();
  }

  Future<void> fetchImage() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final url = await _repository.fetchRandomImage();

      final color = await _colorService.extractDominantColor(url);

      state = state.copyWith(
        imageUrl: url,
        isLoading: false,
        backgroundColor: color,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to load image. Try again.",
      );
    }
  }
}
