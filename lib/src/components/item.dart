import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:sort_it_out/src/components/bin.dart';
import 'package:sort_it_out/src/sort_it_out.dart';

import '../../config.dart';

class Item extends CircleComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<SortItOut> {
  Item({
    required this.currentVelocity,
    required super.position,
    required Paint paint,
    this.itemSize = gameHeight * 0.035,
  }) : super(
          radius: itemSize,
          anchor: Anchor.center,
          paint: paint,
        );

  Vector2 initialVelocity = Vector2.zero();
  Vector2 currentVelocity;
  late Vector2 positionWhenDragged = Vector2.zero();
  final double itemSize;

  @override
  Future<void> onLoad() {
    add(CircleHitbox(isSolid: true));
    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(width / 2, game.width - width / 2);
    position.y = (position.y + event.localDelta.y);
  }

  @override
  void onDragStart(
    DragStartEvent event,
  ) {
    super.onDragStart(event);
    positionWhenDragged = Vector2.copy(position);
    initialVelocity = currentVelocity;
    currentVelocity = Vector2(0, 0);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    currentVelocity = initialVelocity;
    position = positionWhenDragged;
    super.onDragEnd(event);
    if (isColliding) {
      print('Removing object');
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += currentVelocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bin) {
      print('Is on top of bin');
    }
  }
}
