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
} catch CollectionErrors.emptyStack {
    print("The stack is empty")
} catch CollectionErrors.fullStack {
    print("The stack is full")
} catch CollectionErrors.indexNotFound {
    print("Index not found")
}
