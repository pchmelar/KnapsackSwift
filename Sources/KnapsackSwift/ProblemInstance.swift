//
//  ProblemInstance.swift
//  KnapsackSwift
//
//  Created by Petr Chmelar on 25/10/2017.
//  Copyright © 2017 Petr Chmelar All rights reserved.
//

final class ProblemInstance {

    var id: Int = 0
    var size: Int = 0
    var maxWeight: Int = 0
    var items: [ProblemInstanceItem] = []

    init(input: String) {
    		let components = input.components(separatedBy: " ")
    		id = Int(components[0])!
    		size = Int(components[1])!
    		maxWeight = Int(components[2])!
    		for i in stride(from: 3, to: components.count, by: 2) {
    				let item = ProblemInstanceItem(weight: Int(components[i])!, value: Int(components[i+1])!)
    				items.append(item)
				}
    }

    func solveBruteForce(n: Int, currentWeight: Int, currentValue: Int) -> Int {
    
		    if n == -1 {
		        if currentWeight <= maxWeight {
		            return currentValue
		        }
		        return 0
		    }
		    
		    // next step of recursion where we don't take in current item
		    let rec1 = solveBruteForce(n: n-1, currentWeight: currentWeight, currentValue: currentValue)
		    // next step of recursion where we take in current item
		    let rec2 = solveBruteForce(n: n-1, currentWeight: currentWeight + items[n].weight, currentValue: currentValue + items[n].value)
		
		    return max(rec1, rec2)
		}

		func solveHeuristic() -> Int {

				var currentWeight: Int = 0 
				var currentValue: Int = 0

				for item in items.sorted(by: {$0.ratio > $1.ratio}) {
						if currentWeight + item.weight <= maxWeight {
								currentWeight += item.weight
								currentValue += item.value
						}
				}

				return currentValue
		}

		func solveBranchAndBound(n: Int, currentWeight: Int, currentValue: Int, bestValue: Int) -> Int {

				if n == -1 {
		        if currentWeight <= maxWeight {
		            return currentValue
		        }
		        return 0
		    }

		    // determine if we can update the bestValue
		    var newBestValue = bestValue
		    if currentWeight + items[n].weight <= maxWeight {
		    		newBestValue = bestValue + items[n].value
		    }
		    
		    // get sum value of remaining items
		    let potentialValue = Array(items[..<n]).reduce(currentValue) { $0 + $1.value }

		    // next step of recursion where we don't take in current item (only if there is a potential to find better value)
		    var rec1 = 0
		   	if potentialValue >= newBestValue {
		    		rec1 = solveBranchAndBound(n: n-1, currentWeight: currentWeight, currentValue: currentValue, bestValue: newBestValue)
		    }
		    // next step of recursion where we take in current item
		    let rec2 = solveBranchAndBound(n: n-1, currentWeight: currentWeight + items[n].weight, currentValue: currentValue + items[n].value, bestValue: newBestValue)
		
		    return max(rec1, rec2)
		}

}
