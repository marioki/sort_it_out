import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class SpriteManager {
  List<Sprite> petPlasticSprites = [];
  List<Sprite> hdpePlasticSprites = [];
  List<Sprite> paperSprites = [];
  List<Sprite> sodaCansSprites = [];
  List<Sprite> clearGlassSprites = [];
  List<Sprite> colorGlassSprites = [];

  Future<void> loadSprites(FlameGame game) async {
    clearGlassSprites.add(
      await game.loadSprite(
        'items/glass/glass_bottle_1.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(90, 300),
      ),
    );

    colorGlassSprites.add(
      await game.loadSprite(
        'items/glass/color_glass.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(80, 250),
      ),
    );
    colorGlassSprites.add(
      await game.loadSprite(
        'items/glass/color_glass.png',
        srcPosition: Vector2(100, 0),
        srcSize: Vector2(80, 250),
      ),
    );

    colorGlassSprites.add(
      await game.loadSprite(
        'items/glass/color_glass.png',
        srcPosition: Vector2(200, 0),
        srcSize: Vector2(80, 250),
      ),
    );

    paperSprites.add(
      await game.loadSprite(
        'items/paper/paper_1.png',
        srcPosition: Vector2(24, 24),
        srcSize: Vector2(170, 150),
      ),
    );

    hdpePlasticSprites.add(
      await game.loadSprite(
        'items/plastic/hdpe_plastics.png',
        srcPosition: Vector2(480, 55),
        srcSize: Vector2(300, 450),
      ),
    );
    hdpePlasticSprites.add(
      await game.loadSprite(
        'items/plastic/hdpe_plastics.png',
        srcPosition: Vector2(240, 520),
        srcSize: Vector2(180, 430),
      ),
    );

    petPlasticSprites.add(await game.loadSprite(
      'items/plastic/plastic_1.png',
      srcPosition: Vector2(100, 10),
      srcSize: Vector2(110, 270),
    ));

    sodaCansSprites.add(
      await game.loadSprite(
        'items/aluminium/aluminium_1.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(135, 261),
      ),
    );
    sodaCansSprites.add(
      await game.loadSprite(
        'items/aluminium/aluminium_2.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(135, 261),
      ),
    );
    sodaCansSprites.add(
      await game.loadSprite(
        'items/aluminium/aluminium_3.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(135, 261),
      ),
    );
    // Load other sprites similarly
  }
}
