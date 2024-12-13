List<int> intersection(List<int> nums1, List<int> nums2) {
  Map<int, int> map1 = {};
  Map<int, int> map2 = {};

  for (var num in nums1) {
    map1[num] = (map1[num] ?? 0) + 1;
  }

  for (var num in nums2) {
    map2[num] = (map2[num] ?? 0) + 1;
  }

  List<int> result = [];

  for (var num in map1.keys) {
    if (map2.containsKey(num)) {
      int count = map1[num]!.min(map2[num]!);
      result.addAll(List.filled(count, num));
    }
  }

  result.sort();

  return result;
}

void main() {
  List<int> nums1 = [1, 2, 2, 1];
  List<int> nums2 = [2, 2];
  List<int> result = intersection(nums1, nums2);
  print("Intersection: $result");

  List<int> nums3 = [4, 9, 5];
  List<int> nums4 = [9, 4, 9, 8, 4];
  List<int> result2 = intersection(nums3, nums4);
  print("Intersection: $result2");
}
