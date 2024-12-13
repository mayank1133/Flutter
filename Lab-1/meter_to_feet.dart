//Meter To Feet
import 'dart:io';
void main(){
  print('Please enter Distance into METER :-');
  int meter = int.parse(stdin.readLineSync()!);
  print('$meter = ${meter*3.28084 } feet');
}