//Percentage of 5 subjects
import 'dart:io';
void main(){
  int sum = 0;
  for(int i=0;i<5;i++){
    print('Enter $i Subject marks:-');
    int temp = int.parse(stdin.readLineSync()!);
    sum += temp;
  }
  print('your percentage is ${(sum/500)*100}');
}