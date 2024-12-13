//WAP that prompts the user to enter 5 numbers, stores them in a List, and displays them in
// increasing order.
import 'dart:io';
void main(){
  List<int> nums= [];
  for(int i =0;i<5;i++){
    stdout.write('Enter Number ${i+1}');
    nums.add(int.parse(stdin.readLineSync()!));
  }
  nums.sort();
  print(nums);
}