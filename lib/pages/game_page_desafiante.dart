import 'dart:async';
import 'dart:math';

import 'package:cobrinha/pixels/notfood1_pixel.dart';
import 'package:cobrinha/pixels/notfood2_pixel.dart';
import 'package:cobrinha/pixels/notfood_pixel.dart';
import 'package:cobrinha/theme.dart';
import 'package:cobrinha/widgets/game_score_desafiante.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../pixels/blank_pixel.dart';
import '../pixels/food_pixel.dart';
import '../pixels/notfood3_pixel.dart';
import '../pixels/notfood4_pixel.dart';
import '../pixels/snake_pixel.dart';

class GamePageDesafiante extends StatefulWidget {

 
  const GamePageDesafiante({ Key? key,}) : super(key: key);

  @override
  State<GamePageDesafiante> createState() => _GamePageDesafianteState();
}

enum snake_Direction {UP, DOWN, LEFT, RIGHT}

class _GamePageDesafianteState extends State<GamePageDesafiante> {

  SharedPreferences? prefs;

  @override
  void initState() {
    
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {
        
      });
    });
    
  }

  Future<void> initializePreference() async{
    prefs = await SharedPreferences.getInstance();
    
  }

  // grid dimensões
  int rowSize = 20;
  int totalNumberOfSquares = 560;

  //snake posição
  List<int> snakePos = [200,201,202,203,204];

  // direção inicial da cobra

  var currentDirection = snake_Direction.RIGHT;

  int currentScore = 0;
  int highScore = 0;

  int nivel = 400;

  // posição da comida
  int foodPos = 355;

  int notfoodPos = Random().nextInt(560);
  int notfoodpos1 = Random().nextInt(560);
  int notfoodpos2 = Random().nextInt(560);
  int notfoodpos3 = Random().nextInt(560);
  int notfoodpos4 = Random().nextInt(560);

  bool gameStarted = false;

  //iniciar o Jogo
  void startGame(){
    int velocidade;

    

    if(currentScore < 7){
      velocidade = 220000;
    }else if(currentScore < 14){
      velocidade = 120000;
    }else if(currentScore < 21){
      velocidade = 70000;
    }else if(currentScore < 28){
      velocidade = 20000;
    }
    else if(currentScore < 35){
      velocidade = 12000;
    }
    else if(currentScore < 42){
      velocidade = 4000;
    }
    else{
      velocidade = 950;
    }
    gameStarted = true;
    Timer.periodic(Duration(microseconds: velocidade), (timer) { 
      setState(() {
        if (currentScore > highScore) {
            highScore = currentScore;
        }
        setState(() {
          if(currentScore < 0){
          currentScore = 0;
          }
        });


        // cobra se movendo
        moveSnake();

        //checando o game over
        if(gameOver() ){
          timer.cancel();
          //disparando uma mensagem
          showDialog(context: context,
          barrierDismissible: false, 
          builder: (context){
            return AlertDialog(
              title: Text('Fim de Jogo'),
              content: Column(
                children: [
                  Text('Sua Pontuação é ' + currentScore.toString()),
                ],
              ),
              actions: [
                MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  update_leaderboard();
                  newGame();
                },
                child: Text('Continuar'),
                color: Colors.pink,
                )
              ],
            );
          });
        }

      });
    });
  }

  dynamic update_leaderboard() async {
    // print("Here at Uploading Leaderboard");
    prefs = await SharedPreferences.getInstance();
    List<String>? li = prefs?.getStringList("highscoresDesafiante");
    // print(li);
    if (li == null) {
      li = [highScore.toString()];
    } else if (li.length < 1) {
      li.add(highScore.toString());
    } else {
      li.sort((a, b) {
        return int.parse(a).compareTo(int.parse(b));
      });
      if (highScore > int.parse(li[0])) li[0] = highScore.toString();
    }

    prefs?.setStringList("highscoresDesafiante", li);
  }

  

  dynamic print_leaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? li = prefs.getStringList("highscoresDesafiante");
    // print(li);
  }


  void newGame(){
    setState(() {
      snakePos = [0,1,2,3,4];
      foodPos = 100;
      notfoodPos = 450;
      notfoodpos1 = 320;
      notfoodpos2 = 222;
      notfoodpos3 = 333;
      notfoodpos4 = 520;
      currentDirection = snake_Direction.RIGHT;
      gameStarted = false;
      currentScore = 0;
    });
  }

  void eatNotFood(){
    currentScore -= 3;
    while(snakePos.contains(notfoodPos)){
      notfoodPos = Random().nextInt(totalNumberOfSquares);
      if(notfoodPos == foodPos){
        notfoodPos ++;
      }
      
    }
  }

  void eatNotFood1(){
    currentScore--;
    while(snakePos.contains(notfoodpos1)){
      notfoodpos1 = Random().nextInt(totalNumberOfSquares);
      if(notfoodpos1 == foodPos || notfoodpos1 == notfoodPos ){
        notfoodpos1 ++;
      }
    }
  }

  void eatNotFood2(){
    
    while(snakePos.contains(notfoodpos2)){
      notfoodpos2 = Random().nextInt(totalNumberOfSquares);
      if(notfoodpos2 == foodPos || notfoodpos2 == notfoodPos || notfoodpos2 == notfoodpos1 ){
        notfoodpos2 ++;
      }
      
    }
    int ale = Random().nextInt(currentScore);
      currentScore -= ale;
  }

  void eatNotFood3(){
    currentScore = 0;
    while(snakePos.contains(notfoodpos3)){
      notfoodpos3 = Random().nextInt(totalNumberOfSquares);
      if(notfoodpos3 == foodPos || notfoodpos3 == notfoodPos || notfoodpos3 == notfoodpos1 || notfoodpos3 == notfoodpos2 ){
        notfoodpos3 ++;
      }
      
    }
  }

  void eatNotFood4(){
    
    
    while(snakePos.contains(notfoodpos4)){
      notfoodpos4 = Random().nextInt(totalNumberOfSquares);
      if(notfoodpos4 == foodPos || notfoodpos4 == notfoodPos || notfoodpos4 == notfoodpos1 || notfoodpos4 == notfoodpos2 || notfoodpos4 == notfoodpos3){
        notfoodpos4 ++;
      }
    }
    int ale = Random().nextInt(4);
      currentScore += ale;
      if(ale == 5){
        currentScore = 0;
      }
  }

  void eatFood(){
    currentScore++;
    while(snakePos.contains(foodPos)){

      foodPos = Random().nextInt(totalNumberOfSquares);
      notfoodPos = Random().nextInt(totalNumberOfSquares);
      notfoodpos1 = Random().nextInt(totalNumberOfSquares);
      notfoodpos2 = Random().nextInt(totalNumberOfSquares);
      notfoodpos3 = Random().nextInt(totalNumberOfSquares);
      notfoodpos4 = Random().nextInt(totalNumberOfSquares);
    }
  }

  void moveSnake(){
    switch (currentDirection){

      case snake_Direction.RIGHT:
        // adicionando cabeça
        // se a cobra chegar ao final da parede
        if (snakePos.last % rowSize == 19){
          snakePos.add(snakePos.last + 1 - rowSize);
        }else{
          snakePos.add(snakePos.last + 1);
        }
        
        break;
      case snake_Direction.LEFT:
        
        // adicionando cabeça
        // se a cobra chegar ao final da parede
        if (snakePos.last % rowSize == 0){
          snakePos.add(snakePos.last - 1 + rowSize);
        }else{
          snakePos.add(snakePos.last - 1);
        }
        
        break;
      case snake_Direction.UP:
        // adicionando cabeça
        if(snakePos.last < rowSize){
          snakePos.add(snakePos.last - rowSize + totalNumberOfSquares);
        }else{
          snakePos.add(snakePos.last - rowSize);
        }
        
        break;
      case snake_Direction.DOWN:
        // adicionando cabeça
        if(snakePos.last + rowSize > totalNumberOfSquares){
          snakePos.add(snakePos.last + rowSize - totalNumberOfSquares);
        }else{
        snakePos.add(snakePos.last + rowSize);
        }
      
        break;
      default:
    }

    if(snakePos.last == foodPos){
      
      eatFood();
    }else if(snakePos.last == notfoodPos){
      eatNotFood();
    }else if (snakePos.last == notfoodpos1){
      eatNotFood1();
    }
    else if (snakePos.last == notfoodpos2){
      eatNotFood2();
    }else if (snakePos.last == notfoodpos3){
      eatNotFood3();
    }else if (snakePos.last == notfoodpos4){
      eatNotFood4();
    }
    else{
      snakePos.removeAt(0);
    }
  }

  

  // fim de Jogo
  bool gameOver(){
    List<int> bodySnake = snakePos.sublist(0, snakePos.length - 1);

    if(bodySnake.contains(snakePos.last)){
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30,),
          const GameScoreDesafiante(),
          // scores
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // user currrent score
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pontos',
                    style: TextStyle(
                      color: Colors.white)),
                    Text(
                      currentScore.toString(),
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 36),),
                  ],
                ),
                
              ],
            ),
          ),

          //Game Frid
          Expanded(
            flex: 6,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if(details.delta.dy > 0 &&
                  currentDirection != snake_Direction.UP
                ){
                  //mover para Baixo
                  currentDirection = snake_Direction.DOWN;
                }else if(details.delta.dy < 0 &&
                  currentDirection != snake_Direction.DOWN){
                  //mover para cima
                  currentDirection = snake_Direction.UP;
                }
              },onHorizontalDragUpdate: (details) {
                if(details.delta.dx > 0 &&
                  currentDirection != snake_Direction.LEFT){
                  //mover para direita
                  currentDirection = snake_Direction.RIGHT;
                }else if(details.delta.dx < 0 &&
                  currentDirection != snake_Direction.RIGHT){
                  //mover para esquerda
                  currentDirection = snake_Direction.LEFT;
                }
              },
              
              child: GridView.builder(
                itemCount: 560,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize), 
                  itemBuilder: (context, index){
                    if(snakePos.contains(index)){
                      return const SnakePixel();
                    }else if(foodPos == index){
                      return const FoodPixel();
                    }else if(notfoodPos == index){
                      return const NotFoodPixel();
                    } else if(notfoodpos1 == index){
                      return const NotFoodPixel1();
                    }else if(notfoodpos2 == index){
                      return const NotFoodPixel2();
                    }
                    else if(notfoodpos3 == index){
                      return const NotFoodPixel3();
                    }
                    else if(notfoodpos4 == index){
                      return const NotFoodPixel4();
                    }
                    else{
                    return const BlackPixel();
                    }
                  }),
            ),
          ),

          //play Button
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  child: Text('JOGAR'),
                  color: gameStarted ? Colors.grey : Colors.blue,
                  onPressed: gameStarted ? (){} : startGame,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}