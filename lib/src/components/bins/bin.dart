// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:sort_it_out/src/sort_it_out.dart';

abstract class Bin extends SpriteComponent with CollisionCallbacks, HasGameReference<SortItOut> {
  final String label;
  Bin({
    required this.label,
    required super.position,
    required super.size,
  }) : super();

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(isSolid: true));
    return super.onLoad();
  }
}
