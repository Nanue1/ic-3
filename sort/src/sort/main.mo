import Array "mo:base/Array";
import Sort "sort";

actor {
  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  public query func qsort(arr: [Int]): async [Int] {
      let temp = Array.thaw<Int>(arr);
      Sort.quicksort(temp, 0, temp.size()-1);
      Array.freeze(temp)
  };
};



