import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math';

import 'package:flame/game.dart';

class Ball extends SpriteComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  static const _size = 32.0;

  static const double _speed = 250.0;

  String _colFile = 'balle_bleue.png';
  final Vector2 _velocity = Vector2.zero();

  Ball(String col) {
    switch (col) {
      case 'rd':
        _colFile = 'balle_rouge.png';
        break;
      case 'yl':
        _colFile = 'balle_jaune.png';
        break;
      case 'gr':
        _colFile = 'balle_verte.png';
        break;
    }
  }

  void get _resetBall {
    _velocity.x = Random().nextDouble() * _speed;
    _velocity.y = Random().nextDouble() * _speed;
    position.x = Random().nextDouble() * gameRef.size.x;
    position.y = Random().nextDouble() * gameRef.size.y;
  }

  @override
  Future<void> onLoad() async {
    _resetBall;
    size = Vector2(_size, _size);
    sprite = await Sprite.load(_colFile);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }
}
