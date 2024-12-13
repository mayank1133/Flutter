//convert Temperature from F to C
import 'dart:io';
void main(){
  print('Enter your temperature in Fahrenheit:-');
  int a = int.parse(stdin.readLineSync()!);
  print('temmperature in celcius is${(5/9)*(a-32)}');
}