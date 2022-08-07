class GameSettings {
  static const niveis = [1, 2, 3];

  static gameBoardAxisCount(int nivel) {
    if (nivel == 1) {
      return 600;
    } else if (nivel == 2) {
      return 400;
    } else {
      return 200;
    } 
  }
}
