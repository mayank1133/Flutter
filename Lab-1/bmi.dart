//find BMI of user
import 'dart:io';
void main(){
  print('Please enter weight in pounds:-');
  int pound = int.parse(stdin.readLineSync()!);
  print('Please enter height in inches:-');
  int height = int.parse(stdin.readLineSync()!);
  double bmi = ( (pound / (height*height)) * 703);
  print('your BMI is $bmi');
}