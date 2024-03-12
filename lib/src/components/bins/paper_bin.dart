import 'dart:async';

import 'package:flame/game.dart';

import 'bin.dart';

class PaperBin extends Bin {
  PaperBin({
    required super.label,
    required super.position,
    required super.size,
  }) : super(labelPosition: Vector2(size!.x, 0));

  @override
  FutureOr<void> onLoad() {
    sprite = game.paperBin;
    return super.onLoad();
  }
}
