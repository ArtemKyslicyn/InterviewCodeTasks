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


//: [Next](@next)
