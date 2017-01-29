//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print(str)
var arr = [1,2,3,4,5,6,7,8,9,10]

for i in 1...arr.count/2 {
  print(i)
  var t  =  arr[arr.count - i];
  arr[arr.count-i]=arr[i];
  arr[i] = t;
  print(arr[i])
}

for index in 1...5 {
  print("\(index) times 5 is \(index * 5)")
}



