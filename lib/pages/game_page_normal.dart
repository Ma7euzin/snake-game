import 'dart:async';
import 'dart:math';
import 'package:cobrinha/pages/recordes_page_normal.dart';
import 'package:cobrinha/theme.dart';
import 'package:cobrinha/widgets/game_score_normal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pixels/blank_pixel.dart';
import '../pixels/food_pixel.dart';
import '../pixels/snake_pixel.dart';

class GamePageNormal extends StatefulWidget {
 
  const GamePageNormal({ Key? key,}) : super(key: key);

  @override
  State<GamePageNormal> createState() => _GamePageNormalState();
}



enum snake_Direction {UP, DOWN, LEFT, RIGHT}

class _GamePageNormalState extends State<GamePageNormal> {

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
  int foodPos = Random().nextInt(560);

  bool gameStarted = false;

  

  //iniciar o Jogo
  void startGame(){
    int velocidade;

    if(currentScore < 6){
      velocidade = 300000;
    }else if(currentScore < 12){
      velocidade = 150000;
    }else if(currentScore < 18){
      velocidade = 75000;
    }else if(currentScore < 24){
      velocidade = 25000;
    }
    else if(currentScore < 30){
      velocidade = 15000;
    }
    else if(currentScore < 36){
      velocidade = 5000;
    }
    else if(currentScore < 42){
      velocidade = 950;
    }else{
      velocidade = 300;
    }
    gameStarted = true;
    
    Timer.periodic(Duration(microseconds: velocidade), (timer) { 
      setState(() {
        if (currentScore > highScore) {
            highScore = currentScore;
        }

        // cobra se movendo
        moveSnake();

        //checando o game over
        if(gameOver()){
          
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
                  submitScore();
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

  void submitScore(){
    // adicionar dados no firebase
    
  }

  

  dynamic update_leaderboard() async {
    // print("Here at Uploading Leaderboard");
    prefs = await SharedPreferences.getInstance();
    List<String>? li = prefs?.getStringList("highscores");
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

    prefs?.setStringList("highscores", li);
  }

  

  dynamic print_leaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? li = prefs.getStringList("highscores");
    // print(li);
  }

  void newGame(){
    setState(() {
      snakePos = [0,1,2,3,4];
      foodPos = 100;
      currentDirection = snake_Direction.RIGHT;
      gameStarted = false;
      currentScore = 0;
    });
  }

  void eatFood(){
    currentScore++;
    while(snakePos.contains(foodPos)){

      foodPos = Random().nextInt(totalNumberOfSquares);
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
    }else{
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
      
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          SizedBox(height: 30,),
          GameScoreNormal(),
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