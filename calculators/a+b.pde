
//Jason Cameron
//Ms. Basaraba
//2023-11-07
//guessing game

int num1,num2; //program title
void title() {
  println("\t\t\tCalculating game");
}
//program introduction
void introduction() {
  title();
  println("Thisprogram adds to numbers");
}
void userInput() {
  num1=getInt("Enter your first number"); // get the user input 
  num2=getInt("Enter your second number"); // get the user input 

}

void display() {
  int answer;
  answer = num1+num2; 
  println("You entered", num1, "and", num2, "and the answer is", answer);
}

void setup(){
  introduction();
  while (num1!=2&&num2!=2) {
    userInput();
    display();
  }}

