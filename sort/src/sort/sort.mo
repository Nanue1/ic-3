import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Int "mo:base/Int";


module {
    // 双路快排 : 小于等于基数的放在左边、大于基数的放在右边
    public func quicksort(arr: [var Int], left: Int, right: Int) {
        if (left >= right) {
            return;
        };
        let p = partition(arr, left, right);
        quicksort(arr, left, p - 1);
        quicksort(arr, p + 1, right);
    };

    let abs = Int.abs;
    func partition(nums: [var Int], left: Int, right: Int): Int {
        var i = abs(left);
        var j = abs(right); 
        let pivot = nums[abs(left)];
        label l loop {
            while (i < j and nums[j] > pivot) {
                j -= 1;
            };
            while (i < j and nums[i] <= pivot) {
                i+=1;
            };
            if (i >= j) {
                break l;
            };
            swap(nums, i, j);
        };
        swap(nums, abs(left), i);
        return i
    };

    func swap(arr: [var Int], i: Nat, j: Nat) {
        let t= arr[i];
        arr[i] := arr[j];
        arr[j] := t;
    };
}
