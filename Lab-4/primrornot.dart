import 'dart:io';
void main(){
  print("enter a number");
  int n = int.parse(stdin.readLineSync()!);
  if(primecheck(n)==1){
    print("$n is prime");
  }else{
    print("$n is not prime");
  }
}
int primecheck(int a ){
int count=0;
  for(int i = 2 ; i<a/2;i++){
    if(a%i==0){
      count++;
    }
  }
  if(count!=0){
    return 1;
  }
  return 0;
}


