import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    // Customized text style for better visibility
    TextStyle titleStyle = Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: Colors.white, // Ensure high contrast
          shadows: [
            Shadow( // Text shadow for depth and readability
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ],
        );

    TextStyle subtitleStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: Colors.white, // Ensure high contrast
          shadows: [
            Shadow( // Text shadow for depth and readability
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ],
        );

    return Container(
      alignment: const Alignment(0, -0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: titleStyle,
          ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
          const SizedBox(height: 16),
          subtitle != null
              ? Text(
                  subtitle!,
                  style: subtitleStyle,
                ).animate(onPlay: (controller) => controller.repeat()).fadeIn(duration: 1.seconds).then().fadeOut(duration: 1.seconds)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
