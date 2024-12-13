//WAP to print given number in reverse order.
import 'dart:io';
void main(){
  print('Enter Number :-');
  int num = int.parse(stdin.readLineSync()!);
  int rem ;
  int rev=0 ;
  while (num != 0){
    rem = num%10;
    rev = (rev*10) + rem;
    num = num~/10;
    stdout.write(rem);
  }

}