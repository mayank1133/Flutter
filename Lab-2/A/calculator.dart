//WAP to perform Addition, Subtraction, Multiplication, Division based on user choice using if,
// if..else..if, & switch.
import 'dart:io';
void main()
{
  print('Enter the number 1 :-');
  int num1 = int.parse(stdin.readLineSync()!);
  print('WHAT OPERATION WOULD YOU LIKE TO PERFORM!??? :-');
  String s = stdin.readLineSync()!;
  print('Enter the number 2 :-');
  int num2 = int.parse(stdin.readLineSync()!);
  if(s=='+'){
      print('summation of $num1 and $num2 is ${num1+num2}');
  }
  if(s=='-'){
    print('subtraction of $num1 and $num2 is ${num1-num2}');
  }
  if(s=='*'){
    print('Multiplication of $num1 and $num2 is ${num1*num2}');
  }
  if(s=='/'){
    print('Division of $num1 and $num2 is ${num1/num2}');
  }
}