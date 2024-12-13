//WAP to find out largest number from given 3 numbers using conditional operator.

import 'dart:io';
void main(){
  print('Enter first Number :-');
  int num1 = int.parse(stdin.readLineSync()!);
  print('Enter second Number :-');
  int num2 = int.parse(stdin.readLineSync()!);
  print('Enter third Number :-');
  int num3 = int.parse(stdin.readLineSync()!);
   num1>num2 ? (num1>num3?print('largest is $num1'):print('largest is $num3')):(num2>num3?print('largest is $num2'):print('largest is $num3'));
}