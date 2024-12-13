import 'dart:io';
void simpleInterest(double p,double r,double t)
{
  double si = (p*r*t)/100;
  print("Simple Interest Is : $si");
}
void main(){
  stdout.write("Enter principle amount:");
  double p = double.parse(stdin.readLineSync()!);
  stdout.write("Enter rate of interest:");
  double r = double.parse(stdin.readLineSync()!);
  stdout.write("Enter time period :");
  double t = double.parse(stdin.readLineSync()!);

  simpleInterest(p, r, t);

}