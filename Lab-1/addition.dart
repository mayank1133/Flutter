//Addition of two numbers
import 'dart:io';
void main(){
  print('Enter 1st number:-');
  int a = int.parse(stdin.readLineSync()!);
  print('Enter 2st number:-');
  int b = int.parse(stdin.readLineSync()!);
  print('Addition of $a and $b is ${a+b}');
}