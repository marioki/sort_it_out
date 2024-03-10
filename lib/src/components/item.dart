import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:sort_it_out/src/components/waste_basket.dart';
import 'package:sort_it_out/src/sort_it_out.dart';

import '../../config.dart';

abstract class Item extends SpriteComponent
    with DragCallbacks, TapCallbacks, CollisionCallbacks, HasGameReference<SortItOut> {
  Item({
    required this.currentVelocity,
    required super.position,
    required Paint paint,
    required this.addScore,
    this.itemSize = gameHeight * 0.070,
  }) : super(
          anchor: Anchor.center,
          paint: paint,
        );

  Vector2 initialVelocity = Vector2.zero();
  Vector2 currentVelocity;
  late Vector2 positionWhenDragged = Vector2.zero();
  final double itemSize;

  PositionComponent? _inCollisionWithType;
  PositionComponent? get inCollisionWithType => _inCollisionWithType;

  final void Function({int amount}) addScore;

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox.relative(Vector2(0.5, 1),
        parentSize: Vector2(sprite!.image.width.toDouble(), sprite!.image.height.toDouble())));

    
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(width / 2, game.width - width / 2);
    position.y = (position.y + event.localDelta.y);
  }

  @override
  void onTapDown(TapDownEvent event) {
    print('Called on tap Down');

    initialVelocity = currentVelocity;
    currentVelocity = Vector2(0, 0);
    super.onTapDown(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    print('Called Tap Cancelled');
    currentVelocity = initialVelocity;

    super.onTapCancel(event);
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
  void update(double dt) {
    super.update(dt);
    position += currentVelocity * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WasteBasket) {
      print('Deleting Object from memory');
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    _inCollisionWithType = other;
    print('COLLIDING WITH: $_inCollisionWithType');
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    _inCollisionWithType = null;
    super.onCollisionEnd(other);
  }
}
