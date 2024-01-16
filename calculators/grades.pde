//Jason Cameron
//Ms. Basaraba
//2023-11-07
// This program finds your avg for a class until you enter a negative number.

float totalGrade, userInputGrade, currentAvg;  // totalGrade is all the inputs added together, userInputGrade is the current input & currentAvg is what the current avg is
int inputsTotal; // total count of user inputs to calculate avg
void title() {
  println("\t\t\tGradesCalculator");
}
//program introduction
void introduction() {
  title();
  println("This program adds your grades up together and gives you your final avg");
}
void userInput() {
  //while (userInputGrade>1 || grade<0) userInput();
  userInputGrade=getFloat("Enter your grade (out of 100) for this assignemnt, e.g. 75.3. Your current Avg is " + currentAvg); // get the user input
}

void calculateGrade() {
  totalGrade += userInputGrade;
  currentAvg = totalGrade / inputsTotal;
}
void setup() {
  introduction();
  while (userInputGrade>=0) {
    userInput();
    inputsTotal++;
    calculateGrade();
  }
  JOptionPane.showMessageDialog(null, "Your final grade is " + (totalGrade / inputsTotal) + "%");
}
