import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_image_viewer/providers/image_providers.dart';

class ImageViewerScreen extends ConsumerStatefulWidget {
  const ImageViewerScreen({super.key});

  @override
  ConsumerState<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends ConsumerState<ImageViewerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(fadeController);
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageViewModelProvider);
    final vm = ref.read(imageViewModelProvider.notifier);

    if (!state.isLoading) fadeController.forward(from: 0);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBg = isDark ? Colors.grey.shade900 : Colors.grey.shade300;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        color: state.imageUrl == null ? defaultBg : state.backgroundColor,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),

                  /// Image Box
                  _buildImageBox(state),

                  const SizedBox(height: 32),

                  /// Button
                  ElevatedButton(
                    onPressed: state.isLoading ? null : vm.fetchImage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Another",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageBox(state) {
    if (state.isLoading) {
      return const SizedBox(
        width: 300,
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return SizedBox(
        width: 300,
        height: 300,
        child: Center(
          child: Text(
            state.error!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state.imageUrl != null) {
      return FadeTransition(
        opacity: fadeAnimation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: state.imageUrl!,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return const SizedBox(width: 300, height: 300);
  }
}
