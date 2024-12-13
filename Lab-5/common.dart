//WAP to read 2 list and return list that contains only the elements that are common between
// them.
import 'dart:io';
void main(){
  print('Enter size of 1st list :-');
  int n = int.parse(stdin.readLineSync()!);
  print('Enter size of 2st list :-');
  int m = int.parse(stdin.readLineSync()!);
  List<int> cmnlist =[];
  List<int> num1 =[];
  List<int> num2 =[];
  print('Enter List 1st');
  for(int i =0;i<n;i++){
    stdout.write('Enter Number ${i+1} :-');
    num1.add(int.parse(stdin.readLineSync()!));
  }
  print(num1);
  print('Enter List 2st');
  for(int i =0;i<m;i++){
    stdout.write('Enter Number ${i+1} :-');
    num2.add(int.parse(stdin.readLineSync()!));
  }
  print(num2);
  for(int i=0;i<n;i++){
    for(int j=0;j<m;j++){
      if(num1[i]==num2[j]){
        cmnlist.add(num1[i]);
        print(cmnlist);
      }
    }
  }
  print("Common Elements of Both List are \n $cmnlist");


}