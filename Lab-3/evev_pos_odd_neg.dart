//WAP program to calculate the sum of all positive even numbers and the sum of all negative
// odd numbers from a set of numbers. you can enter 0 (zero) to quit the program and thus it
// displays the result.
import 'dart:io';
void main(){
  int even=0;
  int odd=0;
  while(true){
    print('Enter  Number :-');
    int num = int.parse(stdin.readLineSync()!);
    if(num%2==0 && num>=0){
      even = even + num;
    }
    else if(num%2!=0 && num<0){
      odd = odd+num;
    }
    if(num==0){
      break;
    }
  }
  print('Sum of Positive even number is $even');
  print('Sum of negative odd number is $odd');
}