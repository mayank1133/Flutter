import 'dart:io';
void main(){
  print("enter step you want");
  int n = int.parse(stdin.readLineSync()!);
  int a = 0;
  int b = 1;
  stdout.write("${a} ");
  stdout.write("${b} ");
  int step = n-2;
  fibonaci(step,a,b);
}
void  fibonaci(int step , int a , int b){
  if(step==0){
    return ;
  }
  stdout.write("${a+b} ");
  fibonaci(step-1, b, a+b);
}

