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

    func solve(n: Int, currentWeight: Int, currentValue: Int) -> Int {
    
		    if n == -1 {
		        if currentWeight <= maxWeight {
		            return currentValue
		        }
		        return 0
		    }
		    
		    // next step of recursion where we don't take in current item
		    let rec1 = solve(n: n-1, currentWeight: currentWeight, currentValue: currentValue)
		    // next step of recursion where we take in current item
		    let rec2 = solve(n: n-1, currentWeight: currentWeight + items[n].weight, currentValue: currentValue + items[n].value)
		
		    return max(rec1, rec2)
		}
}
