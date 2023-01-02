// ignore_for_file: avoid_print

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math';

import 'package:flame/game.dart';

class Ball extends SpriteComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  static const _size = 32.0;

  static const double _speed = 150.0;

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
    _velocity.x = Random().nextDouble() * _speed + _speed * 0.5;
    _velocity.y = Random().nextDouble() * _speed + _speed * 0.5;
    position.x =
        Random().nextDouble() * gameRef.size.x * 0.5 + gameRef.size.x * 0.25;
    position.y =
        Random().nextDouble() * gameRef.size.y * 0.5 + gameRef.size.y * 0.25;
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
    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    final collisionPoint = intersectionPoints.first;

    if (other is ScreenHitbox) {
      if (collisionPoint.x == 0 || collisionPoint.x == gameRef.size.x) {
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.y == 0 || collisionPoint.y == gameRef.size.y) {
        _velocity.y = -_velocity.y;
      }
    }
    if (other is Ball) {
      _velocity.x = -_velocity.x;
      _velocity.y = -_velocity.y;
    }
  }
}
