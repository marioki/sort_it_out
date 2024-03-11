import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sort_it_out/src/components/bins/aluminium_bin.dart';
import 'package:sort_it_out/src/components/bins/glass_bin.dart';
import 'package:sort_it_out/src/components/item.dart';

class AluminiumCan extends Item {
  AluminiumCan({
    required super.currentVelocity,
    required super.position,
    required super.addScore,
  });

  @override
  Future<void> onLoad() {
    sprite = game.aluminiumSprite;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    FlameAudio.play('can.wav');
    super.onTapDown(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    currentVelocity = initialVelocity;
    position = positionWhenDragged;
    super.onDragEnd(event);
    if (!isColliding) {
      print('Not in bin');
    } else {
      if (inCollisionWithType is AluminiumBin) {
        addScore();
        FlameAudio.play('plus_one.wav');
        removeFromParent();
      } else {
        FlameAudio.play('wrong.wav');
        print('INCORRECT BIN! TRY AGAIN');
      }
    }
  }
}
