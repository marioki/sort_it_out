import 'package:flame/collisions.dart';
import 'package:flame/src/events/messages/drag_end_event.dart';
import 'package:sort_it_out/src/components/bins/paper_bin.dart';
import 'package:sort_it_out/src/components/item.dart';

class PaperItem extends Item {
  PaperItem({
    required super.currentVelocity,
    required super.position,
    required super.paint,
  });

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
        removeFromParent();
      }else {
        print('INCORRECT BIN! TRY AGAIN');
      }
    }
  }
}
