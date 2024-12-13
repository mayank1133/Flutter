//WAP to find factorial of the given number.
import 'dart:io';
void main(){
  print('Enter  Number :-');
  int num = int.parse(stdin.readLineSync()!);
  int ans=1;
  for(int i = 1; i <= num; i++){
    ans*=i;
  }
  print('Factorial for $num is $ans');
}