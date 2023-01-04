// ignore_for_file: avoid_print

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math';

import 'package:flame/game.dart';

class Ball extends SpriteComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  static const _size = 32.0;
  static const double _speed = 150.0;
  static const double _minVelSQ = 0.5 * 0.5 * _speed * _speed;
  double _halfSize = _size * 0.5;
  String _col = 'bl';

  String _colFile = 'balle_bleue.png';
  final Vector2 velocity = Vector2.zero();

  Ball(String col) {
    switch (col) {
      case 'rd':
        _colFile = 'balle_rouge.png';
        _col = col;
        break;
      case 'yl':
        _colFile = 'balle_jaune.png';
        _col = col;
        break;
      case 'gr':
        _colFile = 'balle_verte.png';
        _col = col;
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
    anchor = Anchor.center;
    size = Vector2(_size, _size);
    sprite = await Sprite.load(_colFile);
    final CircleHitbox circleHitbox = CircleHitbox();
    add(circleHitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final Vector2 gameSize = gameRef.size;
    _halfSize = size.x * 0.5;
    bool collided = false;
    if (position.x < _halfSize) {
      position.x = _halfSize;
      velocity.x = -velocity.x;
      collided = true;
    } else if (position.x > gameSize.x - _halfSize) {
      position.x = gameSize.x - _halfSize;
      velocity.x = -velocity.x;
      collided = true;
    }
    if (position.y < _halfSize) {
      position.y = _halfSize;
      velocity.y = -velocity.y;
      collided = true;
    } else if (position.y > gameSize.y - _halfSize) {
      position.y = gameSize.y - _halfSize;
      velocity.y = -velocity.y;
      collided = true;
    }
    if (collided) {
      if (velocity.length2 > _minVelSQ) {
        velocity.scale(0.9);
      }
      size.scale(1.02);
    }
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    //final collisionPoint = intersectionPoints.first;

    if (other is Ball) {
      Vector2 bb = Vector2(other.x - position.x, other.y - position.y);
      double dot = velocity.dot(bb);
      double b2 = bb.length2;
      double scale = dot * 2.0 / b2;
      velocity.addScaled(bb, -scale);
      if (other._col == _col) {
        size.scale(1.02);
        if (velocity.length2 > _minVelSQ) {
          velocity.scale(0.98);
        }
      } else {
        size.scale(0.98);
        velocity.scale(1.02);
      }
    }
  }
}
