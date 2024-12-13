//WAP to make a Simple Calculator using switch...case
import 'dart:io';
void main (){
  print('Enter the number 1 :-');
  int num1 = int.parse(stdin.readLineSync()!);
  print('WHAT OPERATION WOULD YOU LIKE TO PERFORM!??? :-');
  String s = stdin.readLineSync()!;
  print('Enter the number 2 :-');
  int num2 = int.parse(stdin.readLineSync()!);

  switch(s){
    case "+" : print('summation of $num1 and $num2 is ${num1+num2}');
              break;
    case "-" : print('subtraction of $num1 and $num2 is ${num1-num2}');
              break;
    case "*" : print('Multiplication of $num1 and $num2 is ${num1*num2}');
              break;
    case "/" : print('Division of $num1 and $num2 is ${num1/num2}');
              break;
  }
}