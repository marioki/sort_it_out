import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sort_it_out/src/components/bins/bin.dart';
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

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());
    world.addAll([
      GlassBin(
        label: 'Bin 1',
        position: Vector2(0, 0),
        size: Vector2(200, 250),
        paint: Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill,
      ),
      PaperBin(
        label: 'Bin 1',
        position: Vector2(0, 500),
        size: Vector2(200, 250),
        paint: Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill,
      ),
      PlasticBin(
        label: 'Bin 1',
        position: Vector2(0, 1000),
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
}

Item plasticItemSpawn(Vector2 position) => PlasticItem(
      position: position,
      currentVelocity: Vector2(0, 300),
      paint: Paint()
        ..color = Colors.purple
        ..style = PaintingStyle.fill,
    );

Item glassItemSpawn(Vector2 position) => GlassItem(
      position: position,
      currentVelocity: Vector2(0, 300),
      paint: Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill,
    );

Item paperItemSpawn(Vector2 position) => PaperItem(
      position: position,
      currentVelocity: Vector2(0, 300),
      paint: Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill,
    );
