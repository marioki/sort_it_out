import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sort_it_out/src/components/bins/glass_bin.dart';
import 'package:sort_it_out/src/components/bins/plastic_bin.dart';
import 'package:sort_it_out/src/components/item.dart';
import 'package:sort_it_out/src/components/item_spawner.dart';
import 'package:sort_it_out/src/components/items/glass_item.dart';
import 'package:sort_it_out/src/components/items/paper_item.dart';
import 'package:sort_it_out/src/components/items/plastic_bin.dart';

import '../config.dart';
import 'components/bins/paper_bin.dart';
import 'components/components.dart';

class SortItOut extends FlameGame with HasCollisionDetection {
  SortItOut()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  double get width => size.x;
  double get height => size.y;
  final scoreNotifier = ValueNotifier(0);
  String scoreText = 'Score:';

  /// Gives the player points, with a default value +1 points.
  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
    print('Points :${scoreNotifier.value}');
  }

  /// Sets the player's score to 0 again.
  void resetScore() {
    scoreNotifier.value = 0;
  }

  @override
  FutureOr<void> onLoad() async {
    debugMode = false;
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 80,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final scoreComponent = TextComponent(
      text: scoreText,
      position: Vector2.all(30),
      textRenderer: textRenderer,
    );

    camera.viewport.add(scoreComponent);

    scoreNotifier.addListener(() {
      scoreComponent.text = 'Score: ${scoreNotifier.value}';
    });

    world.add(PlayArea());
    world.addAll([
      GlassBin(
        label: 'Bin 1',
        position: Vector2(0, 400),
        size: Vector2(200, 250),
        paint: Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill,
      ),
      PaperBin(
        label: 'Bin 1',
        position: Vector2(0, 800),
        size: Vector2(200, 250),
        paint: Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill,
      ),
      PlasticBin(
        label: 'Bin 1',
        position: Vector2(0, 1200),
        size: Vector2(200, 250),
        paint: Paint()
          ..color = Colors.purple
          ..style = PaintingStyle.fill,
      ),
    ]);
    world.add(
      ItemSpawner(
        spawnFunctions: [plasticItemSpawn, glassItemSpawn, paperItemSpawn],
        minTimePeriod: 0.5,
        maxTimePeriod: 1,
      ),
    );
  }

  Item plasticItemSpawn(Vector2 position) => PlasticItem(
        position: position,
        currentVelocity: Vector2(0, 300),
        paint: Paint()
          ..color = Colors.purple
          ..style = PaintingStyle.fill,
        addScore: addScore,
      );

  Item glassItemSpawn(Vector2 position) => GlassItem(
        position: position,
        currentVelocity: Vector2(0, 300),
        paint: Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill,
        addScore: addScore,
      );

  Item paperItemSpawn(Vector2 position) => PaperItem(
        position: position,
        currentVelocity: Vector2(0, 300),
        paint: Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill,
        addScore: addScore,
      );
}
