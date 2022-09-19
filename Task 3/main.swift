//
// main.swift
// Task 3
//
// Created by Hamad Hamad on 18/09/2022.
//
import Foundation

enum CollectionErrors: Error {
    case emptyStack
    case fullStack
    case indexNotFound
    case fullQueue
    case emptyQueue
}

class Node: Comparable{
    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
    
    static var arr = Array(1...100)
    var id: Int
    var desc: String
    init(_ desc: String) {
        let idx = Int.random(in: 1..<Node.arr.count)
        id = Node.arr[idx]
        Node.arr.remove(at: idx)
        self.desc = desc
    }
    
    func getDesc() -> String {
        return "Node with id \(id) and description: \(desc)"
    }
    
}
class Stack<T:Comparable> {
    var stack: [T] = []
    var maxCapacity = -1
    func push(_ element: T) throws {
        if(stack.count == maxCapacity) {
            throw CollectionErrors.emptyStack
        }
        stack.append(element)
    }
    
    func pop() throws -> T{
        if stack.count == 0 {
            throw CollectionErrors.emptyStack
        }
        return stack.popLast()!
    }
    
    func peek() throws -> T{
        if stack.count == 0 {
            throw CollectionErrors.emptyStack
        }
        return stack.last!
    }
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
}

class Queue<T> {
    var queue: [T] = []
    var maxCapacity = -1
    func add(_ element: T) throws {
        if(queue.count == maxCapacity) {
            throw CollectionErrors.fullQueue
        }
        queue.append(element)
    }
    func remove() throws -> T {
        if (queue.count == 0) {
            throw CollectionErrors.emptyQueue
        }
        let ret = queue.first
        queue.removeFirst()
        return ret!
    }
    func peek() throws -> T {
        if (queue.count == 0) {
            throw CollectionErrors.emptyQueue
        }
        return queue.first!
    }
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
}

extension Stack {
    convenience init(_ maxCapacity: Int) {
        self.init()
        self.maxCapacity = maxCapacity
    }
    
    func insertAt(_ element: T, _ idx: Int) throws {
        if(idx >= self.stack.count) {
            throw CollectionErrors.indexNotFound
        }
        self.stack.insert(element, at: idx)
    }
    
    func removeAt(_ idx: Int) throws {
        if(!stack.indices.contains(idx)) {
            throw CollectionErrors.indexNotFound
        }
        self.stack.remove(at: idx)
    }
    
    func sortStack() {
        self.stack.sort(by: <)
    }
    
    func resize(_ newSize: Int) {
        self.maxCapacity = newSize
    }
    
    func removeDuplicates() {
        self.stack = NSOrderedSet(array: self.stack).map({ $0 as! T })
    }
}

print("Stack test: ")
var stack = Stack<Node>()
do {
    try stack.push(Node("aa"))
    try stack.push(Node("bb"))
    try stack.push(Node("cc"))
    try stack.push(Node("dd"))
    print(try stack.peek().getDesc())
    print(try stack.pop().getDesc())
    try stack.push(Node("ee"))
    print(try stack.pop().getDesc())
    print(stack.isEmpty())
    try stack.insertAt(Node("ff"), 2)
    try stack.removeAt(2)
    stack.sortStack()
    stack.removeDuplicates()
} catch CollectionErrors.emptyStack {
    print("The stack is empty")
} catch CollectionErrors.fullStack {
    print("The stack is full")
} catch CollectionErrors.indexNotFound {
    print("Index not found")
}

print("Queue test: ")
var queue = Queue<Node>()
do {
    try queue.add(Node("aa"))
    try queue.add(Node("bb"))
    try queue.add(Node("cc"))
    try queue.add(Node("dd"))
    print(try queue.peek().getDesc())
    print(try queue.remove().getDesc())
    try queue.add(Node("ee"))
    print(try queue.remove().getDesc())
    print(queue.isEmpty())
} catch CollectionErrors.emptyQueue {
    print("The queue is empty")
} catch CollectionErrors.fullQueue {
    print("The queue is full")
} catch CollectionErrors.indexNotFound {
    print("Index not found")
}
