import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'balls.dart';

// https://www.youtube.com/watch?v=OJsyTv4ZPs8
// https://github.com/svprdga/Flame-Engine-Introduction-Samples/blob/master/lib/ex_1_advanced_2d_movement.dart
// https://code.pieces.app/blog/build-a-pong-game-in-flutter-with-flame

void main() {
  runApp(const GameWidget<BallsGame>.controlled(gameFactory: BallsGame.new));
}

class BallsGame extends FlameGame with HasCollisionDetection {
  late final Ball _ball;

  @override
  Color backgroundColor() => const Color(0xFF353935);

  @override
  Future<void> onLoad() async {
    //await super.onLoad();
    _ball = Ball('yl');
    add(ScreenHitbox());
    await add(_ball);
  }
}
