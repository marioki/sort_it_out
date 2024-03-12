import 'dart:async';

import 'package:flame/game.dart';

import 'bin.dart';

class ColorGlassBin extends Bin {
  ColorGlassBin({
    required super.label,
    required super.position,
    required super.size,
  }) : super(labelPosition: Vector2(0, 0));

  @override
  FutureOr<void> onLoad() {
    sprite = game.colorGlassBin;
    return super.onLoad();
  }
}
