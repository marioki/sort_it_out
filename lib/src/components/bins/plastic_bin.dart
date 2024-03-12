import 'dart:async';

import 'package:flame/game.dart';

import 'bin.dart';

class PlasticBin extends Bin {
  PlasticBin({
    required super.label,
    required super.position,
    required super.size,
  }) : super(labelPosition: Vector2(size!.x, 0));

  @override
  FutureOr<void> onLoad() {
    sprite = game.plasticBin;
    return super.onLoad();
  }
}
