import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'balls.dart';

// https://www.youtube.com/watch?v=OJsyTv4ZPs8
// https://github.com/svprdga/Flame-Engine-Introduction-Samples/blob/master/lib/ex_1_advanced_2d_movement.dart
void main() {
  runApp(const GameWidget<BallsGame>.controlled(gameFactory: BallsGame.new));
}
