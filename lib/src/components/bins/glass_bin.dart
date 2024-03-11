import 'dart:async';

import 'bin.dart';

class GlassBin extends Bin {
  GlassBin({
    required super.label,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() {
    sprite = game.glassBin;
    return super.onLoad();
  }
}
