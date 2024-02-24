import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../sort_it_out.dart';

class PlayArea extends RectangleComponent with HasGameReference<SortItOut> {
  PlayArea()
      : super(
          paint: Paint()..color =  Colors.green.shade200,
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
