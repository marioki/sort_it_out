import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/debug.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';
import 'package:sort_it_out/src/components/bins/glass_bin.dart';
import 'package:sort_it_out/src/components/bins/plastic_bin.dart';
import 'package:sort_it_out/src/components/item.dart';
import 'package:sort_it_out/src/components/item_spawner.dart';
import 'package:sort_it_out/src/components/items/glass/glass_item.dart';
import 'package:sort_it_out/src/components/items/paper/paper_item.dart';
import 'package:sort_it_out/src/components/items/plastic/plastic_item.dart';
import 'package:sort_it_out/src/components/waste_basket.dart';

import '../config.dart';
import 'components/bins/bin.dart';
import 'components/bins/paper_bin.dart';
import 'components/components.dart';

enum PlayState { welcome, playing, gameOver }

class SortItOut extends FlameGame with HasCollisionDetection, TapDetector {
  SortItOut()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        ) {
    difficultyTimer = Timer(
      5,
      repeat: true,
      autoStart: false,
      onTick: () {
        increaseGameDificulty();
      },
    );
  }

  double get width => size.x;
  double get height => size.y;
  final scoreNotifier = ValueNotifier(0);
  String scoreText = 'Score:0';
  late Timer difficultyTimer;
  int dificultyLevelCounter = 0;
  late PlayState _playState;
  PlayState get playState => _playState;
  //Sprites
  //items
  late Sprite paperSprite;
  late Sprite glassSprite;
  late Sprite plasticSprite;
  //bins
  late Sprite plasticBin;
  late Sprite paperBin;
  late Sprite glassBin;
  late Sprite aluminiumBin;

  set playState(PlayState playState) {
    print('Swithing Play state to: $playState');
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    debugMode = false;

    plasticSprite = await loadSprite(
      'items/plastic/plastic_1.png',
      srcPosition: Vector2(120, 10),
      srcSize: Vector2(80, 270),
    );
    paperSprite = await loadSprite(
      'items/paper/paper_1.png',
      srcPosition: Vector2(24, 24),
      srcSize: Vector2(170, 150),
    );
    glassSprite = await loadSprite(
      'items/glass/glass_bottle_1.png',
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(90, 300),
    );

    //BINS

    paperBin = await loadSprite(
      'bins/blue_bin.png',
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(580, 725),
    );

    glassBin = await loadSprite(
      'bins/green_bin.png',
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(580, 740),
    );
    plasticBin = await loadSprite(
      'bins/plastic_bin.png',
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(1100, 1500),
    );

    aluminiumBin = await loadSprite(
      'bins/grey_bin.png',
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(580, 720),
    );

    super.onLoad();
    playState = PlayState.welcome;
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
  }

  Item plasticItemSpawn(Vector2 position, Vector2 velocity) => PlasticWaterBottleItem(
        position: position,
        currentVelocity: velocity,
        addScore: addScore,
      );

  Item glassItemSpawn(Vector2 position, Vector2 velocity) => WineGlassBottleItem(
        position: position,
        currentVelocity: velocity,
        addScore: addScore,
      );

  Item paperItemSpawn(Vector2 position, Vector2 velocity) => NewsPaperItem(
        position: position,
        currentVelocity: velocity,
        addScore: addScore,
      );

  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
    print('Points :${scoreNotifier.value}');
  }

  void resetScore() {
    scoreNotifier.value = 0;
  }

  resetGame() {
    world.removeAll(world.children.query<Item>());
    world.removeAll(world.children.query<Bin>());
    world.removeAll(world.children.query<WasteBasket>());
    world.removeAll(world.children.query<ItemSpawner>());
  }

  void startGame() {
    if (playState == PlayState.playing) return;
    resetGame();
    playState = PlayState.playing;
    resetScore();
    paused = false;
    difficultyTimer.start();

    world.addAll([
      GlassBin(
        label: 'Bin 1',
        position: Vector2(0, 150),
        size: Vector2(300, 420),
      ),
      PaperBin(
        label: 'Bin 1',
        position: Vector2(0, 650),
        size: Vector2(300, 420)* 1.1,
      ),
      PlasticBin(
        label: 'Bin 1',
        position: Vector2(0, 1150),
        size: Vector2(265, 370) * 1.2,
      ),
    ]);
    world.add(
      ItemSpawner(
        spawnFunctions: [glassItemSpawn, paperItemSpawn, plasticItemSpawn],
        minTimePeriod: 2,
        maxTimePeriod: 3,
      ),
    );

    world.add(WasteBasket(
      position: Vector2(0, size.y * 1.1),
      size: Vector2(size.x, 100),
      paint: Paint()
        ..color = Colors.purple
        ..style = PaintingStyle.fill,
    ));
  }

  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  @override
  void update(double dt) {
    difficultyTimer.update(dt);
    super.update(dt);
  }

  void increaseGameDificulty() {
    dificultyLevelCounter += 1;

    print('Increasing Game Dificulty to level $dificultyLevelCounter');
    world.children.query<ItemSpawner>().first.increaseSpawnerDificulty();
  }
}
