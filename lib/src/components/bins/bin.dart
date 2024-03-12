// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

import 'package:sort_it_out/src/sort_it_out.dart';

abstract class Bin extends SpriteComponent with CollisionCallbacks, HasGameReference<SortItOut> {
  final String label;
  final Vector2 labelPosition;
  Bin({
    required this.label,
    required this.labelPosition,
    required super.position,
    required super.size,
  }) : super();

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(isSolid: true));
    final textComponent = TextComponent(
      text: label,
      position: labelPosition,
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32.0,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ],
        ),
      ),
    );

    add(textComponent);
    return super.onLoad();
  }
}
