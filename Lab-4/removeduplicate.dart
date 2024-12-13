
void main() {
  List<int> nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4];

  int uniqueCount = removeDuplicates(nums);
  print("Number of unique elements: $uniqueCount");
  print("Modified array: $nums");
}

int removeDuplicates(List<int> nums) {
  if (nums.isEmpty) return 0;

  int index = 1;
  for (int i = 1; i < nums.length; i++) {
    if (nums[i] != nums[i - 1]) {
      nums[index] = nums[i];
      index++;
    }
  }

  // Fill the remaining part of the list with underscores (or any placeholder).
  for (int i = index; i < nums.length; i++) {
    nums[i] = -1; // Placeholder for removed elements
  }

  return index;
}

