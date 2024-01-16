//Jason Cameron
//Ms. Basaraba
//2023-11-07
//guessing game with input checking

int guess;
//program title
void title() {
  println("\t\t\tGuessing game");
}
//program introduction
void introduction() {
  title(); // call the title 
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
  int answer=5; // generate the random answer
  userInput(); // get the users input
  if (guess == answer) { // if the guess was correct
    println("Right on! the answer was", answer); // tell user that the guess was incorrect
  } else if (guess > answer) { // if the guess was too high 
    println("too high!");
  } else if (guess < answer) println("too low!"); // if the user was too low 
}
void setup() {
  introduction();
  display();
}