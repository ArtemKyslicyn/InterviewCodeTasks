//: Playground - noun: a place where people can play

import Foundation



/*:1 Write code  for reverse array*/
  var arr = [1,2,3,4,5,6,7,8,9,10]

  for i in 0...arr.count/2 {
      print(i)
      var t  =  arr[arr.count - i - 1];
      arr[arr.count-i - 1]=arr[i];
      arr[i] = t;
      print(arr[i])
  }

  print(arr)

/*: Write code to check a String is palindrome or not?*/
  var palindrom:String = "Eve"

  func isPalindrom(string:String) -> Bool{
    
    
    return false
  }

//: [Next](@next)
//1) Write code to check a String is palindrome or not? (solution)
//Palindrome are those String whose reverse is equal to original.This can be done by using either StringBuffer reverse() method or by technique demonstrated in the solution here.
//
//
//2) Write a method which will remove any given character from a String? (solution)
//hint : you can remove a given character from String by converting it into character array and then using substring() method for removing them from output string.
//
//
//3) Print all permutation of String both iterative and Recursive way? (solution)
//
//
//4) Write a function to find out longest palindrome in a given string? (solution)
//
//
//5) How to find first non repeated character of a given String? (solution)
//
//
//6) How to count occurrence of a given character in a String? (solution)
//
//
//7) How to check if two String are Anagram? (solution)
//
//
//8) How to convert numeric String to int in Java? (solution)


//Read more: http://javarevisited.blogspot.com/2011/06/top-programming-interview-questions.html#ixzz4XAIkYLm3

