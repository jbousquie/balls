import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class Ball extends SpriteComponent with KeyboardHandler {
  static const _size = 32.0;

  static const double _speed = 250.0;
  static const double _friction = 0.9;

  Vector2 _movementVector = Vector2.zero();

  bool _isPressingLeft = false;
  bool _isPressingRight = false;
  bool _isPressingUp = false;
  bool _isPressingDown = false;

  @override
  Future<void> onLoad() async {
    size = Vector2(_size, _size);
    sprite = await Sprite.load('balle_bleue.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    final Vector2 inputVector = Vector2.zero();

    if (_isPressingLeft) {
      inputVector.x -= 1.0;
    } else if (_isPressingRight) {
      inputVector.x += 1.0;
    }

    if (_isPressingUp) {
      inputVector.y -= 1.0;
    } else if (_isPressingDown) {
      inputVector.y += 1.0;
    }

    if (!inputVector.isZero()) {
      _movementVector = inputVector;
      _movementVector.normalize();
      _movementVector *= _speed * dt;
    } else {
      _movementVector *= _friction;
    }
    position += _movementVector;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final isKeyUp = event is RawKeyUpEvent;

    if (isKeyUp) {
      final logicalKey = event.data.logicalKey;
      if (logicalKey == LogicalKeyboardKey.arrowLeft) {
        _isPressingLeft = false;
      } else if (logicalKey == LogicalKeyboardKey.arrowRight) {
        _isPressingRight = false;
      } else if (logicalKey == LogicalKeyboardKey.arrowDown) {
        _isPressingDown = false;
      } else if (logicalKey == LogicalKeyboardKey.arrowUp) {
        _isPressingUp = false;
      }
    }

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _isPressingLeft = true;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        _isPressingRight = true;
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        _isPressingUp = true;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        _isPressingDown = true;
      }
    }

    return true;
  }
}

class BallsGame extends FlameGame with HasKeyboardHandlerComponents {
  late final Ball _ball;

  @override
  Color backgroundColor() => const Color(0xFF353935);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _ball = Ball();
    await add(_ball);
  }
}
