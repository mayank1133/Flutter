// WAP to print numbers between two given numbers which is divisible by 2 but not divisible by
// 3.
import 'dart:io';
void main(){
  stdout.write('Enter Starting Number :-');
  int num1 = int.parse(stdin.readLineSync()!);
  stdout.write('Enter Ending Number :-');
  int num2 = int.parse(stdin.readLineSync()!);
  for (int i = num1 ; i<=num2 ; i++)
    {
      if (i%2==0 && i % 3 != 0){
        print('$i is divisible by 2 but not divisible by 3');
      }
    }
}
