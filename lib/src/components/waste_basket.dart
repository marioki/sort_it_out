// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:sort_it_out/src/components/items/paper_item.dart';

import '../sort_it_out.dart';
import 'items/glass_item.dart';
import 'items/plastic_item.dart';

class WasteBasket extends RectangleComponent with CollisionCallbacks, HasGameReference<SortItOut> {
  int aluminiumItemCounter = 0;
  int foodItemCounter = 0;
  int plasticItemCounter = 0;
  int paperItemCounter = 0;
  int glassItemCounter = 0;
  int combinedItemCount = 0;
  int lives = 5;
  WasteBasket({required super.paint, required super.position, required super.size});

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (lives <= 0) {
//TODO: Lossing state;
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    combinedItemCount += 1;
    minusOneLive();
    print('Combined Item Counter: $combinedItemCount');
    switch (other) {
      case PaperItem _:
        paperItemCounter += 1;
        print('Wasted Paper Counter: $paperItemCounter');
        break;
      case GlassItem _:
        glassItemCounter += 1;
        print('Wasted Glass Counter: $glassItemCounter');
        break;
      case PlasticItem _:
        plasticItemCounter += 1;
        print('Wasted Plastic Counter: $plasticItemCounter');
        break;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void minusOneLive() {
    if (lives > 0) {
      lives -= 1;
    }
    print('Lives Left: $lives');
  }
}
