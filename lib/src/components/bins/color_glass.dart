import 'dart:async';

import 'bin.dart';

class ColorGlassBin extends Bin {
  ColorGlassBin({
    required super.label,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() {
    sprite = game.colorGlassBin;
    return super.onLoad();
  }
}
