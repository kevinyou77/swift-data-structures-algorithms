import Foundation

class Node {
	
	let value: Int
	weak var prev: Node?
	var next: Node?
	
	init(value: Int) {
		self.value = value
	}
}

class LinkedList {
	
	var head: Node
	var tail: Node
	
	var count: Int
	
	init(root: Node) {
		
		self.head = root
		self.tail = root
		
		count = 0
	}
	
	func append(value: Int) {
		
		let newNode = Node(value: value)
		
		newNode.prev = tail
		tail.next = newNode
		
		tail = newNode
		
		count = count + 1
	}
	
	func insert(value: Int, at index: Int) {

		let newNode = Node(value: value)

		var curr: Node? = head

		var counter = 0

		var prev: Node?
		while curr != nil {

			if index == counter {

				prev = curr?.prev
				break
			}

			curr = curr?.next
			counter = counter + 1
		}

		newNode.next = curr
		newNode.prev = prev
		curr?.prev = newNode
	}
	
	func delete(at index: Int) {
		
		var curr: Node? = head
		
		var counter = 0
		
		var prev: Node?
		while curr != nil {
			
			if counter == index {
				
				prev = curr?.prev
				break
			}
			
			curr = curr?.next
			counter = counter + 1
		}
		
		if let prev = prev {
			
			prev.next = curr?.next
			curr?.next?.prev = prev

			curr?.next = nil
			curr?.prev = nil
		}
		
		count = count - 1
	}
	
	func print() -> [Int] {
		
		var arr = [Int]()
		
		var curr: Node? = head
		while curr != nil {
			
			if let val = curr?.value {
				arr.append(val)
			}
			
			curr = curr?.next
		}
		
		return arr
	}
}

//let linkedList = LinkedList(root: Node(value: 1))
//linkedList.append(value: 2)
//linkedList.append(value: 5)
//linkedList.append(value: 9)
//
//linkedList.delete(at: 2)
//linkedList.delete(at: 1)
//
////linkedList.insert(value: 2, at: 1)
//
//linkedList.print()
