import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:sort_it_out/src/components/bins/paper_bin.dart';
import 'package:sort_it_out/src/components/item.dart';

class PaperItem extends Item {
  PaperItem({
    required super.currentVelocity,
    required super.position,
    required super.paint,
    required super.addScore,
  });

  @override
  Future<void> onLoad() {
    sprite = game.paperSprite;
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
      if (inCollisionWithType is PaperBin) {
        print('Correct bin...Removing Item');
        addScore();
        removeFromParent();
      } else {
        print('INCORRECT BIN! TRY AGAIN');
      }
    }
  }
}
