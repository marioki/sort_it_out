// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:sort_it_out/config.dart';
import 'package:sort_it_out/src/components/item.dart';
import 'package:sort_it_out/src/components/items/paper_item.dart';

import 'package:sort_it_out/src/sort_it_out.dart';

class ItemSpawner extends PositionComponent with HasGameReference<SortItOut> {
  final List<Item> components;
  final double minTimePeriod;
  final double maxTimePeriod;
  late Timer _timer;
  late double timerDuration;
  final double minXPosition;
  final double maxXPosition;

  ItemSpawner({
    required this.components,
    required this.minTimePeriod,
    required this.maxTimePeriod,
    this.minXPosition = (gameWidth * 0.45),
    this.maxXPosition = (gameWidth * 0.55),
  }) : super() {
    timerDuration = minTimePeriod;

    _timer = Timer(
      timerDuration,
      repeat: true,
      onTick: () {
        _spawnItem();
      },
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
    Item newItemData = components.random();
    game.world.add(
      PaperItem(
        currentVelocity: newItemData.currentVelocity,
        position: Vector2(Random().nextDouble() * (maxXPosition - minXPosition) + minXPosition, 0),
        paint: newItemData.paint,
      ),
    );

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
