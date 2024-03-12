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
    clearGlassSprites.add(await game.loadSprite(
      'items/glass/glass_bottle_1.png',
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(90, 300),
    ));

    paperSprites.add(
      await game.loadSprite(
        'items/paper/paper_1.png',
        srcPosition: Vector2(24, 24),
        srcSize: Vector2(170, 150),
      ),
    );

    hdpePlasticSprites.add(
      await game.loadSprite(
        'items/plastic/pet_plastics.png',
        srcPosition: Vector2(480, 55),
        srcSize: Vector2(300, 450),
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
        srcSize: Vector2(150, 300),
      ),
    );
    sodaCansSprites.add(
      await game.loadSprite(
        'items/aluminium/aluminium_2.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(150, 300),
      ),
    );
    sodaCansSprites.add(
      await game.loadSprite(
        'items/aluminium/aluminium_3.png',
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(150, 300),
      ),
    );
    // Load other sprites similarly
  }
}
