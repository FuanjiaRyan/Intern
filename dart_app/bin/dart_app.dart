void main() {
  ///Declaring variables
  // String name = "Ryan";
  // int age = 45;
  // bool isStudent = false;
  // double gpa = 1.9;
  //
  // print("My name is $name, I am $age, I had $gpa gpa last semester");

  ///Arithmetic Operators(+, -, /, *)
  // int num1 = 5;
  // int num2 = 10;
  //
  // print(num1+num2);
  // print(num2-num1);
  // print(num2/num1);
  // print(num2*num1);

  ///Assignment operators(==, +=, -+, /=, *=)
  // int num1 = 30;
  // int num2 = 10;
  //
  // num1 += 8;
  // num2 -= 8;
  //
  // print(num1);
  // print(num2);

  ///Comparison Operators(>, <, >=, <=, !=, ==)
  // int age = 20;
  //
  // print(age >= 18);
  // print(age==18);
  // print(age<20);
  // print(age>20);

  ///Logical Operators(&&, !)
  // bool hasId = false;
  // bool isAdult = true;
  //
  // print(hasId && isAdult);
  // print(!hasId);
  // print(!isAdult);

  ///Increment and Decrement operators(++, --)
  // int count = 5;
  //
  // count--;
  // print(count);

  ///Control structures(If, else if, loop)
  //if statement
  // if(condition){
  //   print(statement)
  // }

  // int age = 18;
  //
  // if(age>18){
  //   print("You are an adult");
  // }
  // else{
  //   print("You are a child");
  // }

  // int score = 10;
  //
  // if(score>70){
  //   print("A Grade");
  // }
  // else if(score>60){
  //   print("B Grade");
  // }
  // else if(score>50){
  //   print("C Grade");
  // }
  // else {
  //   print("Failed");
  // }

  // for(initialization; condition; increment){
  //   Code to ececute
  // }

  // for(int i=0; i<100; i++){
  //   print("$i. I love you");
  // }

  ///Functions
  greet("Ryan", 23);
  greet("Aisha", 40);

}

void greet(String name, int age){
  print("My name is $name, I am $age");
}
