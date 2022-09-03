import Debug "mo:base/Debug";
import Sort "sort";


do {
    let nums = [var -7,-9,89,0,13,-15];
    Sort.quicksort(nums,0,nums.size()-1);
    Debug.print(debug_show(nums));
}