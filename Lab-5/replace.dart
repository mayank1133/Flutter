//WAP that creates List with following value:“Delhi”, “Mumbai”, “Bangalore”, “Hyderabad” and
// “Ahmedabad” Replace “Ahmedabad” with “Surat” in above List.
import 'dart:io';
void main(){
  print('How many would you like to add :-');
  int n = int.parse(stdin.readLineSync()!);
  List<String> city = [];
  for(int i =0;i<n;i++){
    stdout.write('Enter city :-');
    city.add(stdin.readLineSync()!);
  }
  for(int i=0;i<n;i++){
    if(city[i]=='Ahmedabad'){
      city[i]='surat';
    }
  }
  print(city);
}