//Check if the  number is ugly or not
import 'dart:io';
void main(){
  print('Enter the Number :-');
  int no = int.parse(stdin.readLineSync()!);
  for(int i = 0; i <= no; i++ ){
    if(no % i == 0){
      if(i!=2||i!=3||i!=5){
        if()
        bool check = false;
      }
    }
  }
  if(check==false){
    print('$no is not ugly');
  }
  else{
    print('$no is ugly');
  }
}