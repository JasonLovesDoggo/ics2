//Jason Cameron
//Ms. Basaraba
//2023-11-09
//guessing game v3. This program will generate a random number between 10 and 30 and give the user 3 attempts to guess it correctly.

int guess; // The current guess.
int answer; // the solution to the game.
//program title
void title() {
  println("\t\t\tGuessing game");
}

void randNum() {
  answer=(int)random(10, 31); // generate a random number between 10 and 30.
}

//program introduction
void introduction() { 
  title();
  println("Try to guess a number between 10 and 30");
  randNum();
}
void goodbye() { // display a goodbye message to the user.
  println("Goodbye gamer, I hope you enjoyed my random number guessing game. Author: Jason Cameron");
}
void userInput() { 
  guess=getInt("Enter your guess"); // get the user input
  if (guess > 30 || guess < 10) { // check if the guess is over 10 but under or equal to 30
    JOptionPane.showMessageDialog(null, "Invalid Guess, it must be between 10 and 30, please try again");
    userInput();
  }
}
void display() {
  int guessCount = 0; // The total count of guesses
  while (guess!=answer && guessCount < 3) { // while the guess count is less than 3 and the guess isnt the answer.
    guessCount++;
    userInput();
    if (guess > answer) { // if the guess was too high
      println("too high!");
    } else if (guess < answer) println("too low!"); // if the guess was too low.
  }
  if (guess!=answer) { // if the guess count was greater than 3 but they did not get the answer.
    println("sorry, max of only 3 guesses allowed. The Number was", answer);
  } else {
    println("perfect! You only took", guessCount, "guesses"); 
  }
}


void setup() {
  introduction();
  display();
}