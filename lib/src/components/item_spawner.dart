// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flame/components.dart';
import 'package:sort_it_out/src/components/item.dart';

import 'package:sort_it_out/src/sort_it_out.dart';

class ItemSpawner extends PositionComponent with HasGameReference<SortItOut> {
  final List<PositionComponent> components;
  final double minTimePeriod;
  final double maxTimePeriod;
  late Timer _timer;
  late double timerDuration;

  ItemSpawner({
    required this.components,
    required this.minTimePeriod,
    required this.maxTimePeriod,
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
    game.world.add(Item(position: Vector2(game.size.x / 2, 0), currentVelocity: Vector2(0, 100)));

    setTimerDuration();
  }

  void setTimerDuration() {
    timerDuration = Random().nextDouble() * maxTimePeriod;
    if (timerDuration < minTimePeriod) {
      timerDuration = minTimePeriod;
    }
    _timer.limit = timerDuration;
    print('next timer Duration: $timerDuration');
  }
}
