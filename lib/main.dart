import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/overlays/game_state_overlay.dart';
import 'src/sort_it_out.dart';

void main() {
  final game = SortItOut();
  runApp(GameWidget(
    game: game,
    overlayBuilderMap: {
      PlayState.welcome.name: (context, game) => const OverlayScreen(
            title: 'TAP TO PLAY',
            subtitle: 'Use arrow keys or swipe',
          ),
      PlayState.gameOver.name: (context, game) => const OverlayScreen(
            title: 'G A M E   O V E R',
            subtitle: 'Tap to Play Again',
          ),
    },
  ));
}
