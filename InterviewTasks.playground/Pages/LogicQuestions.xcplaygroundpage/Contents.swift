//: Playground - noun: a place where people can play

import Foundation



/*: Write code  for reverse array*/
  var arr = [1,2,3,4,5,6,7,8,9,10]

  for i in 0...arr.count/2 {
      //print(i)
      var t  =  arr[arr.count - i - 1];
      arr[arr.count-i - 1]=arr[i];
      arr[i] = t;
      //print(arr[i])
  }

  print(arr)

/*: Write code to check a String is palindrome or not?*/
func isPalindrom(string:String) -> Bool{
  
  for i in 0...string.characters.count/2{
    //print(string[i])
    let startChar = string[string.index(string.startIndex, offsetBy: i)]
    let endChar = string[string.index(string.startIndex, offsetBy: string.characters.count - i - 1)]
    if startChar != endChar{
      print("startChar \(startChar) endChar \(endChar)")
      return false
    }
    
  }
  
  return  true
}

  var string:String = "eve"
  isPalindrom(string:string)

  var string2:String = "nopalindrom"
  isPalindrom(string:string2)

/*: Write a method which will remove any given character from a String?*/


//: [Next](@next)




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

