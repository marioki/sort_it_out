import 'package:flame/events.dart';
import 'package:sort_it_out/src/components/bins/glass_bin.dart';
import 'package:sort_it_out/src/components/item.dart';

class GlassItem extends Item {
  GlassItem({
    required super.currentVelocity,
    required super.position,
    required super.paint,
    required super.addScore,
  });

  @override
  Future<void> onLoad() {
    sprite = game.glassSprite;
    return super.onLoad();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    currentVelocity = initialVelocity;
    position = positionWhenDragged;
    super.onDragEnd(event);
    if (!isColliding) {
      print('Not in bin');
    } else {
      if (inCollisionWithType is GlassBin) {
        print('Correct bin...Removing Item');
        addScore();
        removeFromParent();
      } else {
        print('INCORRECT BIN! TRY AGAIN');
      }
    }
  }
}
