//: [Previous](@previous)

import Foundation


public struct LinkedListIterator<T: Equatable>: IteratorProtocol {
  public typealias Element = Node<T>
  
  /// The current node in the iteration
  private var currentNode: Element?
  
  private init(startNode: Element?) {
    currentNode = startNode
  }
  
  public mutating func next() -> LinkedListIterator.Element? {
    let node = currentNode
    currentNode = currentNode?.next
    
    return node
  }
}



public class Node<T: Equatable> {
  typealias NodeType = Node<T>
  
  /// The value contained in this node
  public let value: T
  var next: NodeType? = nil
  var previous: NodeType? = nil
  
  public init(value: T) {
    self.value = value
  }
}

class LinkedList<T: Equatable>{
  
  public private (set)  var  count:Int = 0
  public typealias Iterator = LinkedListIterator<T>
  public typealias NodeType = Node<T>
  public typealias Element = Node<T>
  
  var start: NodeType? {
    didSet {
      // Special case for a 1 element list
      if end == nil {
        end = start
      }
    }
  }
  
   var end: NodeType? {
    didSet {
      // Special case for a 1 element list
      if start == nil {
        start = end
      }
    }
  }
  
  /// Create a new LinkedList
  ///
  /// - returns: An empty LinkedList
  public init() {
    
  }

  
  public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
    for element in elements {
      appendNode(value: element)
    }
  }
  
  public var isEmpty: Bool {
    get {
      return count == 0
    }
  }
  
  private func iterate(block: (_ node: NodeType, _ index: Int) throws -> NodeType?) rethrows -> NodeType? {
    var node = start
    var index = 0
    
    while node != nil {
      let result = try block(node!, index)
      if result != nil {
        return result
      }
      index += 1
      node = node?.next
    }
    
    return nil
  }
  

  func appendNode(value:T){
    let previousEnd = end
    end = NodeType(value: value)
    
    end?.previous = previousEnd
    previousEnd?.next = end
    
    count += 1
  }
  
  public func nodeAt(index: Int) -> NodeType {
    precondition(index >= 0 && index < count, "Index \(index) out of bounds")
    
    let result = iterate {
      if $1 == index {
        return $0
      }
      
      return nil
    }
    
    return result!
  }
  

  /// Return the value at a given index
  ///
  /// - complexity: O(n)
  /// - parameter index: The index in the list
  ///
  /// - returns: The value at the provided index.
  public func valueAt(index: Int) -> T {
    let node = nodeAt(index: index)
    return node.value
  }
  
  
  
//  func backRecursiveIteration(block:(_ node: NodeType) throws -> NodeType?) {
//      iterateItem(node: end,block: block)
//   // return nil
//  }
//  
//  
//  
//  func iterateItem(node:NodeType?,block:(_ node: NodeType) throws -> NodeType?) rethrows -> NodeType? {
//    
//    if let previosNode = node?.previous {
//     print("node value \(node?.value)")
//    
//    let value  = try block(node!)
//      
//    try iterateItem(node:previosNode,block: block)
//    }else{
//      //return node
//    }
//    
//  }
  
  
  /// Remove a give node from the list
  ///
  /// - complexity: O(1)
  /// - parameter node: The node to remove
  public func remove(node: NodeType) {
    let nextNode = node.next
    let previousNode = node.previous
    
    if node === start && node === end {
      start = nil
      end = nil
    }
    else if node === start {
      start = node.next
    } else if node === end {
      end = node.previous
    } else {
      previousNode?.next = nextNode
      nextNode?.previous = previousNode
    }
    
    count -= 1
    assert(
      (end != nil && start != nil && count >= 1) || (end == nil && start == nil && count == 0),
      "Internal invariant not upheld at the end of remove"
    )
  }
  
  /// Remove a give node from the list at a given index
  ///
  /// - complexity: O(n)
  /// - parameter atIndex: The index of the value to remove
  public func remove(atIndex index: Int) {
    precondition(index >= 0 && index < count, "Index \(index) out of bounds")
    
    // Find the node
    let result = iterate {
      if $1 == index {
        return $0
      }
      return nil
    }
    
    // Remove the node
    remove(node: result!)
  }
  
  
  
//  public func makeIterator() -> LinkedList.Iterator {
//    let iterator =  LinkedListIterator<T>(startNode: nil)
//    return iterator
//  }

  
  

}




let list = LinkedList([1,2,3])

let list2 = LinkedList([1,2,3])

//list.backRecursiveIteration(block:{ item in
// 
//  return item
//})

var list3 = LinkedList<Int>()
list3.appendNode(value: 10)
list3.appendNode(value: 20)
list3.appendNode(value: 30)

//for node in list {
//  print("\(node)")
//}
//
//let values: [Int] = list.map {
//  $0.value
//}

print()


/*14) How do you find middle element of a linked list in single pass?
To answer this programming question I would say you start with simple solution on which you traverse the LinkedList until you find the tail of linked list where it points to null to find the length of linked list and then reiterating till middle. After this answer interviewer will ask you find the middle element in single pass and there you can explain that by doing space-time trade-off you can use two pointers one incrementing one step at a time and other incrementing two step a time, so when first pointer reaches end of linked second pointer will point to the middle element.



15) How do you find 3rd element from last in single pass? (solution)
This programming question is similar to above and can be solved by using 2 pointers, start second pointer when first pointer reaches third place.


16) How do you find if there is any loop in singly linked list? How do you find the start of the loop? (solution)
This programming question can also be solved using 2 pointers and if you increase one pointer one step at a time and other as two steps at a time they will meet in some point if there is a loop.


17) How do you reverse a singly linked list? (solution)


18) Difference between linked list and array data structure? (answer)





Read more: http://javarevisited.blogspot.com/2011/06/top-programming-interview-questions.html#ixzz4XddMXey8
*/

//: [Next](@next)
