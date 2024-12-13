//WAP to find friends detail by their name using dictionary. (Create local dictionary and search
// from it using Map<String,Object?> & Model Class).
import 'dart:io';
class Friend{
  String name;
  int age;
  Friend({required this.name, required this.age});
}
void main(){
  Map<String,Friend> fd = Map();
  print('How many friend would you like to add :-');
  int n = int.parse(stdin.readLineSync()!);
  for(int i =0;i<n;i++){
    stdout.write('Enter Name :-');
    String name=stdin.readLineSync()!;
    stdout.write('Enter Age :-');
    int age = int.parse(stdin.readLineSync()!);
    fd[name]=Friend(name:name,age:age);
  }
  fd.values.toList().forEach((ele){
    print(ele.name);
    print(ele.age);
  });
}