import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sort_it_out/src/components/bins/hdpe_bin.dart';
import 'package:sort_it_out/src/components/items/item.dart';

class HDPEItem extends Item {
  HDPEItem(
      {required super.currentVelocity,
      required super.position,
      required super.addScore,
      super.size});

  @override
  Future<void> onLoad() {
    sprite = game.spriteManager
        .hdpePlasticSprites[Random().nextInt(game.spriteManager.hdpePlasticSprites.length)];
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    FlameAudio.play('plastic_bottle.wav');
    super.onTapDown(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    currentVelocity = initialVelocity;
    position = positionWhenDragged;
    super.onDragEnd(event);
    if (!isColliding) {
    } else {
      if (inCollisionWithType is HDPEBin) {
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
