import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_image_viewer/data/repositories/image_repository.dart';
import 'package:random_image_viewer/data/services/color_extractor_service.dart';
import 'package:random_image_viewer/data/models/image_state.dart';
import 'package:random_image_viewer/presentation/viewmodels/image_viewmodel.dart';

final imageRepositoryProvider = Provider((ref) => ImageRepository());
final colorExtractorProvider = Provider((ref) => ColorExtractorService());

final imageViewModelProvider =
    StateNotifierProvider<ImageViewModel, ImageState>((ref) {
      return ImageViewModel(
        ref.read(imageRepositoryProvider),
        ref.read(colorExtractorProvider),
      );
    });
