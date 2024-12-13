 import 'dart:io';
void main(){
List<int> mylist = [];
print("enter step");
int step = int.parse(stdin.readLineSync()!);
for(int i = 0 ; i<step; i++){
  print("enter the digit");
  mylist.add(int.parse(stdin.readLineSync()!));
 }
print(EvenOddsep(mylist));

}
Map EvenOddsep(List mylist){
  int n = mylist.length;
  int evencount=0;
  int oddcount=0;
  for(int i = 0 ; i < n ;i++){
    if(mylist[i]%2==0){
      evencount++;
    }else{
      oddcount++;
    }
  }
  return {"even":evencount,"odd":oddcount};
}
