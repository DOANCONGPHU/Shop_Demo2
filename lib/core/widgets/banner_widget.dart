import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatelessWidget {
  final List<String> bannerImages;
  const BannerWidget({super.key, required this.bannerImages});
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: bannerImages.length,
            physics: const PageScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                child: Image.network(
                  bannerImages[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 300,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: controller,
          count: bannerImages.length,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
