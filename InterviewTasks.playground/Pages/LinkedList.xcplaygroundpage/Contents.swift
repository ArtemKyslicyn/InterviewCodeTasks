//: [Previous](@previous)

import Foundation


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
 
  public typealias NodeType = Node<T>
  
  private var start: NodeType? {
    didSet {
      // Special case for a 1 element list
      if end == nil {
        end = start
      }
    }
  }
  
  private var end: NodeType? {
    didSet {
      // Special case for a 1 element list
      if start == nil {
        start = end
      }
    }
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
  
  func recursionNodeAtIndex(index:Int){
    
  }
  
  func 
  
}

let list = LinkedList([1,2,3])

let list2 = LinkedList([1,2,3])



//: [Next](@next)
