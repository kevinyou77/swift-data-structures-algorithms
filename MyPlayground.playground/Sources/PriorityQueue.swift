import Foundation

class PriorityQueue<T: Comparable> {
	
	private var heapSize: Int
	private var heapCapacity: Int
	
	private var heap: [T?]
	
	private var map: [Int: T]
	
	var isEmpty: Bool {
		heapSize == 0
	}
	
	var elements: [T?] {
		heap
	}
	
	init() {
		
		heapSize = 0
		heapCapacity = 0
		
		heap = [T]()
		map = [Int: T]()
	}
	
	func contains(_ item: T) -> Bool {
		heap.firstIndex(of: item) != nil
	}
	
	func add(element: T) {
		
		if heapSize < heapCapacity {
			
			heap[heapSize] = element
		} else {
			
			heap.append(element)
			heapCapacity += 1
		}
		
		swim(index: heapSize)
		heapSize += 1
	}
	
	func swim(index: Int) {
		
		var idx = index
		var parent = (idx - 1) / 2
		
		while idx > 0 && less(i: idx, j: parent) {
			
			swap(idx, parent)
			
			idx = parent
			parent = (idx - 1) / 2
		}
	}
	
	func sink(index: Int) {
		
		while true {
			
			var idx = index
			
			let left = (2 * idx) + 1
			let right = (2 * idx) + 2
			
			var smallest = left
			
			if right < heapSize && less(i: right, j: left) {
				smallest = right
			}
			
			if left >= heapSize || less(i: idx, j: smallest) {
				break
			}
			
			swap(smallest, idx)
			idx = smallest
		}
	}
	
	func remove(at i: Int) -> T? {
		
		if isEmpty || i > heapSize {
			return nil
		}
		
		heapSize -= 1
		
		let removed = heap[i]
		swap(i, heapSize)
		
		heap[heapSize] = nil
		
		if i == heapSize {
			return removed
		}
		
		let elem = heap[i]
		
		sink(index: i)
		
		if heap[i] == elem {
			swim(index: i)
		}
		
		return removed
	}
	
	func less(i: Int, j: Int) -> Bool {
		
		let iValue = heap[i]
		let jValue = heap[j]
		
		guard
			let iV = iValue,
			let jV = jValue else {
			
				return false
		}
		
		return iV <= jV
	}
	
	func isMinHeap(index: Int = 0) -> Bool {
		
		if index >= heapSize {
			return true
		}
		
		let left = (2 * index) + 1
		let right = (2 * index) + 2
		
		if left < heapSize && !less(i: index, j: left) {
			return false
		}
		
		if right < heapSize && !less(i: index, j: right) {
			return false
		}
		
		return isMinHeap(index: left) && isMinHeap(index: right)
	}
	
	private func swap(_ i: Int, _ j: Int) {
		
		let temp = heap[i]
		heap[i] = heap[j]
		heap[j] = temp
	}
}

let priorityQueue = PriorityQueue<Int>()

priorityQueue.add(element: 10)
priorityQueue.add(element: 30)
priorityQueue.add(element: 8)
priorityQueue.add(element: 7)
priorityQueue.add(element: 9)
priorityQueue.add(element: 15)

print(priorityQueue.elements)
