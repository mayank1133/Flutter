//WAP to read marks of five subjects. Calculate percentage and print class accordingly. Fail
// below 35, Pass Class between 35 to 45, Second Class between 45 to 60, First Class between 60
// to 70, Distinction if more than 70.

import 'dart:io';
void main(){
  int sum = 0;
  for(int i=1;i<=5;i++){
    print('Enter $i Subject marks:-');
    int temp = int.parse(stdin.readLineSync()!);
    sum += temp;
  }
  double per = (sum/500)*100;
  if(per > 70.0){
    print(' your percentage is $per and you are DISTINCTION  ');
  }
  if(per <= 70.0 && per >60.0){
    print(' your percentage is $per and you passed form FIRST CLASS ');
  }
  if(per <= 60.0 && per >45.0){
    print(' your percentage is $per and you passed form second CLASS ');
  }
  if(per <= 35.0 && per >45.0){
    print(' your percentage is $per and you just passed need IMPROVEMENT ');
  }
  if(per < 35.0){
    print(' your percentage is $per and YOU HAVE FAILED IN YOUR CLASS!!!! ');
  }
}