//WAP to check whether the given number is positive or negative.
import 'dart:io';
void main()
{
  print('Enter the number :-');
  int num = int.parse(stdin.readLineSync()!);
  if(num>0){
    print('Entered number is positive');
  }
  else{
    print('Entered number is negative');
  }
}