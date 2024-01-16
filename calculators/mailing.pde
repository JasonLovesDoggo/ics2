//Jason Cameron
//Ms. Basaraba
//2023-11-13
//Mail cost calculator based off of error trapped user input package weight.


boolean firstRun = true; // if the program has been run before ( to show if you continue or exit)
boolean onMenu = true; // if the program is currently on the menu
float packageWeight; // weight of the package (in grams)
int menuOption; // which menu option is going to be selected.
float cost; // final cost of the letter.
void setup () {
  intro();
  mainMenu();
}

void intro() {
  title();
  println("Welcome!, please follow the menu below!");
  println("If you want to calculate your package's cost, enter 1, if you want to exit, enter 2");
}
void title() {
  println("MAILING COST CALCULATOR");
}

void goodbye() {
  println("Good bye! Hope you enjoyed this calculator by Jason Cameron");
}

void mainMenu() {
  onMenu = true;
  userInput();
  if (menuOption == 1) { // if you want to calculate
    display();
  } else goodbye(); // if you want to exit.
}


void userInput() {
  if (onMenu == true) {
    if (firstRun) {
      println("1. Calculate Cost");
    } else {
      println("1. Continue");
    }
    print("2. Exit");
    menuOption = getInt("");
    if (menuOption > 2 || menuOption < 1) { // error trapping
      JOptionPane.showMessageDialog(null, "Invalid option, must be either 1 (calculate) or 2 (exit)");
      intro();
      userInput();
    }
  } else if (onMenu == false) {
    packageWeight = getFloat("Enter your package's weight in grams. E.G. 208.3 or 306");
    if (packageWeight < 1) { // error trapping
      JOptionPane.showMessageDialog(null, "Invalid option, the package weight must be positive (greater than one)");
      userInput();
    }
  }
}
void calculateCost() {
  if (packageWeight <= 100) {
    cost = 1.8;
  } else if (packageWeight <= 200) {
    cost = 2.95;
  } else if (packageWeight <= 300) {
    cost = 4.1;
  } else if (packageWeight <= 400) {
    cost = 4.7;
  } else if (packageWeight <= 500) {
    cost = 5.05;
  } else {
    cost = 5.05;
    packageWeight -= 500;
    int remaining = ceil(packageWeight/50);
    cost += float(nf(remaining * 1.2, 0, 2)); // round to 2 decimal places to fix floating point issues.
  }
}
void display() {
  onMenu = false;
  firstRun = false;
  userInput();
  calculateCost();
  println("Your final cost will be $" + cost);
  delay(400); // delay for 0.4s so the user has time to read the output.
  mainMenu();
}

