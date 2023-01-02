// ignore_for_file: avoid_print

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math';

import 'package:flame/game.dart';

class Ball extends SpriteComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  static const _size = 24.0;

  static const double _speed = 150.0;

  String _colFile = 'balle_bleue.png';
  final Vector2 velocity = Vector2.zero();

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
    double sign = Random().nextBool() ? 1.0 : -1.0;
    velocity.x = sign * (Random().nextDouble() * _speed + _speed * 0.5);
    sign = Random().nextBool() ? 1.0 : -1.0;
    velocity.y = sign * (Random().nextDouble() * _speed + _speed * 0.5);
    position.x =
        Random().nextDouble() * gameRef.size.x * 0.75 + gameRef.size.x * 0.25;
    position.y =
        Random().nextDouble() * gameRef.size.y * 0.75 + gameRef.size.y * 0.25;
  }

  @override
  Future<void> onLoad() async {
    _resetBall;
    size = Vector2(_size, _size);
    sprite = await Sprite.load(_colFile);
    final CircleHitbox circleHitbox = CircleHitbox();
    //circleHitbox.collisionType = CollisionType.passive;
    add(circleHitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final Vector2 gameSize = gameRef.size;
    if (position.x < 0) {
      position.x = 0;
      velocity.x = -velocity.x;
    } else if (position.x > gameSize.x - _size) {
      position.x = gameSize.x - _size;
      velocity.x = -velocity.x;
    }
    if (position.y < 0) {
      position.y = 0;
      velocity.y = -velocity.y;
    } else if (position.y > gameSize.y - _size) {
      position.y = gameSize.y - _size;
      velocity.y = -velocity.y;
    }
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    final collisionPoint = intersectionPoints.first;

    if (other is Ball) {
      if ((collisionPoint.y <= position.y + _size && velocity.y > 0) ||
          (collisionPoint.y >= position.y - _size && velocity.y < 0)) {
        velocity.y = -velocity.y;
      } else if ((collisionPoint.x <= position.x + _size && velocity.x > 0) ||
          (collisionPoint.x >= position.x - _size && velocity.x < 0)) {
        velocity.x = -velocity.x;
      }
    }
  }
}
