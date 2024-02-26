import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:sort_it_out/src/components/item.dart';
import 'package:sort_it_out/src/sort_it_out.dart';

import '../../config.dart';
// Import your item subclasses

class ItemSpawner extends PositionComponent with HasGameReference<SortItOut> {
  final double minTimePeriod;
  final double maxTimePeriod;
  late Timer _timer;
  late double timerDuration;
  final double minXPosition;
  final double maxXPosition;
  // Registry of spawn functions
  List<Item Function(Vector2)> spawnFunctions;

  ItemSpawner({
    required this.minTimePeriod,
    required this.maxTimePeriod,
    required this.spawnFunctions,
    this.minXPosition = (gameWidth * 0.45),
    this.maxXPosition = (gameWidth * 0.55),
  }) : super() {
    timerDuration = minTimePeriod;

    _timer = Timer(
      timerDuration,
      repeat: true,
      onTick: _spawnItem,
    );

    setTimerDuration();
  }

  @override
  void update(double dt) {
    _timer.update(dt); // This is crucial for the timer's progress and triggering onTick
    super.update(dt);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  void _spawnItem() {
    // Select a spawn function at random
    var spawnFunction = spawnFunctions[Random().nextInt(spawnFunctions.length)];

    // Create a new item instance
    Vector2 newPosition = Vector2(Random().nextDouble() * (maxXPosition - minXPosition) + minXPosition, 0);
    Paint newPaint = Paint()..color = Colors.blue; // Example paint, adjust as needed

    Item newItem = spawnFunction(newPosition);

    game.world.add(newItem);

    setTimerDuration();
  }

  void setTimerDuration() {
    timerDuration = Random().nextDouble() * (maxTimePeriod - minTimePeriod) + minTimePeriod;

    _timer
      ..stop()
      ..limit = timerDuration
      ..start();
  }
}
