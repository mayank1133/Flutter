import 'dart:io';
void main(){
  print("enter number one");
  int a = int.parse(stdin.readLineSync()!);
  print("enter number two");
  int b = int.parse(stdin.readLineSync()!);
  findhigest(a,b);
}
void findhigest(int a , int b){
  if(a>b){
    print("$a is largest");
  }else{
    print("$b is largest");
  }
}

