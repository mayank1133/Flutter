//WAP to find whether the given number is prime or not.
import 'dart:io';
void main(){
  print('Enter Number :-');
  int num = int.parse(stdin.readLineSync()!);
  int count=0;
  for(int i = 1; i<=num ; i++){
    if(num%i==0){
      count++;
    }
  }
  if(count<=2){
    print('$num is Prime Number');
  }
  else{
    print('$num is not a prime Number');
  }
}