import 'dart:async';

import 'bin.dart';

class AluminiumBin extends Bin {
  AluminiumBin({
    required super.label,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() {
    sprite = game.aluminiumBin;
    return super.onLoad();
  }
}
