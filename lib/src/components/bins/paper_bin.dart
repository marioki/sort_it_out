import 'dart:async';

import 'bin.dart';

class PaperBin extends Bin {
  PaperBin({
    required super.label,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() {
    sprite = game.paperBin;
    return super.onLoad();
  }
}
