//
//  main.swift
//  KnapsackSwift
//
//  Created by Petr Chmelar on 24/10/2017.
//  Copyright © 2017 Petr Chmelar All rights reserved.
//

let weight: [Int] = [10, 7, 19, 9, 1, 20, 2, 8].reversed()
let value: [Int] = [15, 11, 2, 3, 20, 1, 4, 8].reversed()
let maxWeight: Int = 50

var bestValue: Int = 0
var totalWeight: Int = 0

func solve(n: Int, currentWeight: Int, currentValue: Int) {
    
    if n == -1 {
        // update bestValue
        if currentWeight <= maxWeight, currentValue > bestValue {
            bestValue = currentValue
            totalWeight = currentWeight
        }
        // end of recursion
        return
    }
    
    // next step of recursion where we don't take in current item
    solve(n: n-1, currentWeight: currentWeight, currentValue: currentValue)
    // next step of recursion where we take in current item
    solve(n: n-1, currentWeight: currentWeight + weight[n], currentValue: currentValue + value[n])
}

solve(n: weight.count-1, currentWeight: 0, currentValue: 0)
print("Best value: \(bestValue)")
print("Total weight: \(totalWeight)")
