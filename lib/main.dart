import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/sort_it_out.dart';

void main() {
  final game = SortItOut();
  runApp(GameWidget(game: game));
}
