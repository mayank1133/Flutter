//WAP to find out largest number from given three numbers without using Logical Operator.
import 'dart:io';
void main(){
  print('Enter first Number :-');
  int num1 = int.parse(stdin.readLineSync()!);
  print('Enter second Number :-');
  int num2 = int.parse(stdin.readLineSync()!);
  print('Enter third Number :-');
  int num3 = int.parse(stdin.readLineSync()!);
  if(num1>num2){
    if(num1>num3){
      print('largest number is $num1');
    }
    else{
      print('largest number is $num3');
    }
  }
  if(num2>num3){
    print('largest number is $num2');
  }
  else{
    print('largest number is $num3');
  }
}