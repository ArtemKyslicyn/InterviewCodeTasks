# Interview Code Tasks Swift Playground


##### Write code to check a String is palindrome or not? 

`func isPalindrom(string:String) -> Bool{
  
  for i in 0...string.characters.count/2{
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
  isPalindrom(string:string2)`


##### Write a method which will remove any given character from a String? 

##### Print all permutation of String both iterative and Recursive way? 

##### Write a function to find out longest palindrome in a given string? 

##### How to find first non repeated character of a given String? 

##### How to count occurrence of a given character in a String? 

##### How to check if two String are Anagram? 

##### How to convert numeric String to int in Swift? 

