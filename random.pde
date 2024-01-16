int age;
float grade;
String name;
char gender;
import javax.swing.*;

void setup() {
  intro();
}

boolean intro() {
  println("Sentance creator 30000");
  age = getInt("what's your age? e.g. 7");
  grade = getFloat("what's your grade? e.g. 94.2");
  name = getString("what's your name? E.g. Jason");
  gender = getChar("what's your gender? (m or f)");
  if (gender != 'm' && gender != 'f') {
    JOptionPane.showMessageDialog(null, "Invalid Gender, please try again");
    intro();
    return false;
  };
  String message = "Hi " + name + " you are currently " + age + " years old with a grade of " + grade + " your gender is " +  gender;
  JOptionPane.showMessageDialog(null, message);
  println(message);
  return true;
 
};