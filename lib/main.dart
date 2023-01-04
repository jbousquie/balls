import 'package:flame/components.dart';
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
  int max = 40;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //add(ScreenHitbox());
    List<Ball> balls = [];
    for (var i = 0; i < max; i++) {
      balls.add(Ball('rd'));
      balls.add(Ball('gr'));
      balls.add(Ball('yl'));
      balls.add(Ball('bl'));
    }
    await addAll(balls);
    add(FpsTextComponent());
  }
}
