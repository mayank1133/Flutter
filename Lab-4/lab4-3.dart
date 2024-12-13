import 'dart:io';
void fiboonachi(int n) {
 int a =0;
 int b=1;
 print(a);
 print(b);
if(n<=2){
  return;
}
 for (int i=0;i<n-2;i++) {

  int sum = a+b;
  print (sum);
  a=b;
  b=sum;

 }

}
void main() {

  stdout.write("enter a num");
  int n= int.parse(stdin.readLineSync()!);
  fiboonachi(5);
}