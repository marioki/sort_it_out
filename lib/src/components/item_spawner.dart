import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sort_it_out/src/components/items/item.dart';
import 'package:sort_it_out/src/sort_it_out.dart';

import '../../config.dart';
/**
 * Dificulty Controls
 * Dificulty increases with time
 * Speed of the items increase
 * Spawn Time interval range decreases
 * Item variaty increases
 */

class ItemSpawner extends PositionComponent with HasGameReference<SortItOut> {
  double minTimePeriod;
  double maxTimePeriod;
  double itemSpeedMultiplier = 1;

  late Timer _timer;
  late double timerDuration;
  final double minXPosition;
  final double maxXPosition;

  List<Item Function(Vector2, Vector2)> spawnFunctions;

  ItemSpawner({
    required this.minTimePeriod,
    required this.maxTimePeriod,
    required this.spawnFunctions,
    this.minXPosition = (gameWidth * 0.40),
    this.maxXPosition = (gameWidth * 0.60),
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
    _timer.update(dt);
    super.update(dt);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  void _spawnItem() {
    var spawnFunction = spawnFunctions[Random().nextInt(spawnFunctions.length)];

    Vector2 newPosition =
        Vector2(Random().nextDouble() * (maxXPosition - minXPosition) + minXPosition, 0);
    Item newItem = spawnFunction(newPosition, (Vector2(0, 300) * itemSpeedMultiplier));
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

  increaseSpawnerDificulty() {
    print('[Dificulty] Increasing Item Spawner Dificulty.');

    if (itemSpeedMultiplier <= 1.8) {
      itemSpeedMultiplier += 0.03;
    }
    minTimePeriod = max(.6, (minTimePeriod - minTimePeriod * 0.10));
    maxTimePeriod = max(.7, (maxTimePeriod - maxTimePeriod * 0.10));

    print('[Dificulty] Min Time Period: $minTimePeriod');
    print('[Dificulty] Max Time Period: $maxTimePeriod');
    print('[Dificulty] Item Speed Multiplier: $itemSpeedMultiplier');
  }
}
