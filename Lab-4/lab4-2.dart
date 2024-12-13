import 'dart:io';
void maxValue(int a,int b) {
  if(a>b) {
    print("Max is  $a");

  }
  else{
    print("Max is $b");
  }

}
void main() {

  stdout.write("enter a num");
  int a= int.parse(stdin.readLineSync()!);
  stdout.write("enter a num");
  int b= int.parse(stdin.readLineSync()!);
  maxValue(a,b);
}