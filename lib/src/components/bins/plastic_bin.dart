import 'dart:async';

import 'bin.dart';

class PlasticBin extends Bin {
  PlasticBin({
    required super.label,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() {
    sprite = game.plasticBin;
    return super.onLoad();
  }
}
