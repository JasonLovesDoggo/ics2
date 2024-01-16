// Jason Cameron
// Ms. Basaraba
// 2023-11-06
// This Program will generate a times table when you specify the base & middle value
int middleValue;
int baseValue;
String tab = "\t";
String tab4 = "\t\t\t\t";
void setup() {
  size(0, 0);
  askUser();
}

void calculateTable() {
      println(tab4+tab+tab, "      Base Value",   tab, "    Multiplied by", tab, "       Result");
  for (int i=(middleValue -5); i<=middleValue+6; i++) {
    int tableCalculation = baseValue * i;
     
    println(tab4+tab+tab+tab, baseValue, tab + "*" + tab, i, tab+ "="+tab, tableCalculation);
  }
};
void askUser() {
  println(tab4+tab4 + "WELCOME TO THE TIMES TABLE CALCULATOR");
  println(tab4+"You will input a middle value and a base value, the middle value represents the middle of the 12 times table.");
  println(tab4 + "E.g. if you set middle value to 5 and base of 3, the program will output 3 * 0, 3*1 … 3*11");
  middleValue = getInt(tab4+tab4+"Please Enter Your Middle Value");
  baseValue = getInt(tab4+tab4+" Please Enter Your Base Value");
  calculateTable();
}
