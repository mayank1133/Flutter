//WAP to create and read phonebook dictionary.
import 'dart:io';
void main(){
  Map<String,int> pd = Map();
  print('How many Numbers would you like to add :-');
  int n = int.parse(stdin.readLineSync()!);
  for(int i =0;i<n;i++){
    print('Enter Name and Number of ${i+1} :-');
    pd[stdin.readLineSync()!]=int.parse(stdin.readLineSync()!);
  }
  stdout.write('Give a NAME whose number is needed:-');
  String s1=stdin.readLineSync()!;
  print('Number of $s1 is :-');
  stdout.write(pd[s1]);
}