/Jason Cameron
//Ms. Basaraba
//2023-11-07
//guessing game

int guess;
int guessCount = 0;
//program title
void title() {
  println("\t\t\tGuessing game");
}
//program introduction
void introduction() {
  title();
  println("Try to guess a number betwen 1 and 10");
}
void userInput() {
  guess=getInt("Enter your guess"); // get the user input 
  if (guess > 10 || guess < 0) { // check if the guess is over 0 but under or equal to 10
    JOptionPane.showMessageDialog(null, "Invalid Guess, it must be between 0 and 10, please try again");
    userInput();
  }
}
void display() {
  int answer=(int)random(0, 13200);
  while (guess!=answer) {
    guessCount++;
    userInput();
    if (guess > answer) {
      println("too high!");
    } else if (guess < answer) println("too low!");
  }
  println("perfect! You only took", guessCount, "guesses");
}
void setup() {
  introduction();
  display();
}