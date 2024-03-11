import 'package:flame/events.dart';
import 'package:sort_it_out/src/components/bins/plastic_bin.dart';
import 'package:sort_it_out/src/components/item.dart';

class PlasticWaterBottleItem extends Item {
  PlasticWaterBottleItem({
    required super.currentVelocity,
    required super.position,
    required super.addScore,
  });

  @override
  Future<void> onLoad() {
    sprite = game.plasticSprite;

    return super.onLoad();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    currentVelocity = initialVelocity;
    position = positionWhenDragged;
    super.onDragEnd(event);
    if (!isColliding) {
    } else {
      if (inCollisionWithType is PlasticBin) {
        addScore();
        removeFromParent();
      } else {
        print('INCORRECT BIN! TRY AGAIN');
      }
    }
  }
}
