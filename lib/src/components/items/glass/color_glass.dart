import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sort_it_out/src/components/bins/color_glass.dart';
import 'package:sort_it_out/src/components/items/item.dart';

class ColorGlassBottle extends Item {
  ColorGlassBottle({
    required super.currentVelocity,
    required super.position,
    required super.addScore,
  });

  @override
  Future<void> onLoad() {
    sprite = game.spriteManager
        .colorGlassSprites[Random().nextInt(game.spriteManager.colorGlassSprites.length)];
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    FlameAudio.play('glass_bottle.wav');
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
      if (inCollisionWithType is ColorGlassBin) {
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
