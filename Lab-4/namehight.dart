void main() {
  List<String> names1 = ["Mary", "John", "Emma"];
  List<int> heights1 = [18, 180, 170];

  // 18 , 180 , 170

  sortNamesByHeight(names1, heights1);
}

void  sortNamesByHeight(List<String> names, List<int> heights) {
  for(int i = 0 ; i<heights.length ; i++){
    for(int j = i+1 ; j<heights.length ; j++){
      if(heights[i] > heights[j]){
        int temp = heights[i];
        heights[i]=heights[j];
        heights[j]=temp;

        String temp2 = names[i];
        names[i]=names[j];
        names[j]=temp2;
      }
    }
  }
  print(names);
  print(heights);


}
