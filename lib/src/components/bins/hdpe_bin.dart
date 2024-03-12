import 'dart:async';

import 'bin.dart';

class HDPEBin extends Bin {
  HDPEBin({
    required super.label,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() {
    sprite = game.hdpeBin;
    return super.onLoad();
  }
}
