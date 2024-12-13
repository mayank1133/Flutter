//WAP to accept a number and check whether the number is prime or not. Use method name
// check (int n). The method returns 1, if the number is prime otherwise, it returns 0

import 'dart:io';
int check(int n) {
int count =0;
  for(int i=0;i<=n;i++) {
    if(i%n==0) {
      count++;
    }
  }
  if(count==2){
  return 1;
  }
  else{
  return 0;
  }
}

void main() {
  stdout.write("Enter number");
  int n =int.parse(stdin.readLineSync()!) ;
  check(n);

}