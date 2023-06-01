import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_snake_game/blank_pixel.dart';
import 'package:flutter_snake_game/food_pixel.dart';
import 'package:flutter_snake_game/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum snake_Direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {

  // grid dimensions
  int rowSize = 10;
  int totalNumberOfSquares = 100;

  // snake position
  List<int> snakePos = [
    0,
    1,
    2,
  ]; 

  // snake direction is initially to the right
  var currentDirection = snake_Direction.RIGHT;

  // food position
  int foodPos = 55;

  // start the game!
  // every 200 miliseconds, we are moving the snake
  void startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {

        // keep the snake moving!
        moveSnake();

        // snake is eating food
      });
     });
  }

  void moveSnake() {
    switch (currentDirection) {
      case snake_Direction.RIGHT: 
        {
          // add a head
          // if snake is at the right wall, need to re-adjust
          if (snakePos.last % rowSize == 9) {
            snakePos.add(snakePos.last + 1 - rowSize);
          } else {
            snakePos.add(snakePos.last + 1);
          }

          // remove tail
          snakePos.removeAt(0);
        }

        break;

      case snake_Direction.LEFT: 
        {
          // add a head
          // if snake is at the right wall, need to re-adjust
          if (snakePos.last % rowSize == 0) {
            snakePos.add(snakePos.last - 1 + rowSize);
          } else {
            snakePos.add(snakePos.last - 1);
          }

          // remove tail
          snakePos.removeAt(0);
        }
        
        break;  

      case snake_Direction.UP: 
        {
          // add a head
          if (snakePos.last < rowSize) {
            snakePos.add(snakePos.last - rowSize + totalNumberOfSquares);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }

          // remove tail
          snakePos.removeAt(0);
        }
        
        break;

      case snake_Direction.DOWN: 
        {
          // add a head
          if (snakePos.last + rowSize > totalNumberOfSquares) {
            snakePos.add(snakePos.last + rowSize - totalNumberOfSquares);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }

          // remove tail
          snakePos.removeAt(0);
        }
        
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // high scores
          Expanded(
            child: Container(),
          ),

          // game grid
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 && currentDirection != snake_Direction.UP) {
                  currentDirection = snake_Direction.DOWN;
                } else if ( details.delta.dy < 0 && currentDirection != snake_Direction.DOWN) {
                  currentDirection = snake_Direction.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 && currentDirection != snake_Direction.LEFT) {
                  currentDirection = snake_Direction.RIGHT;
                } else if ( details.delta.dx < 0 && currentDirection != snake_Direction.RIGHT) {
                  currentDirection = snake_Direction.LEFT;
                }
              },
              child: GridView.builder(
                itemCount: totalNumberOfSquares,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize),
                itemBuilder: (context,index) {
                  if (snakePos.contains(index)) {
                    return const SnakePixel();
                  }
                  else if (foodPos == index) {
                    return const FoodPixel();
                  }
                  else {
                    return const BlankPixel();
                  }
                }),
            ),
          ),

          // play button
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  child: Text('PLAY'),
                  color: Colors.pink,
                  onPressed: startGame,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}