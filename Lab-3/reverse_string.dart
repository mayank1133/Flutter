//WAP to print reverse string.
import 'dart:io';
void main(){
  print('Enter a string:-');
  String str = stdin.readLineSync()!;
  for(int i = str.length-1 ; i>=0; i--){
    stdout.write(str[i]);
  }
}