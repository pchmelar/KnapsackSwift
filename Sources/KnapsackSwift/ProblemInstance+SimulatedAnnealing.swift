//
//  ProblemInstance+SimulatedAnnealing.swift
//  KnapsackSwift
//
//  Created by Petr Chmelar on 14/12/2017.
//  Copyright © 2017 Petr Chmelar All rights reserved.
//

import Foundation

extension ProblemInstance {

    private func generateRandomInitialSolution() -> [Int] {

    		var solution: [Int] = []
    		var allowedPositions: [Int] = Array(0..<items.count)

    		while allowedPositions.count > 0 {

    				let randomIndex = Int(arc4random_uniform(UInt32(allowedPositions.count)))
    				let selectedPosition = allowedPositions.remove(at: randomIndex)
    				solution.append(selectedPosition)

    				if getWeightOfSolution(solution: solution) > maxWeight {
    						solution.removeLast()
    						break
    				}
    		}
    		return solution
    }

    private func getWeightOfSolution(solution: [Int]) -> Int {
    		var weight = 0
    		for i in solution {
    				weight += items[i].weight
    		}
    		return weight
    }

    private func getValueOfSolution(solution: [Int]) -> Int {
    		var value = 0
    		for i in solution {
    				value += items[i].value
    		}
    		return value
    }

    private func generateAllMovesForSolution(solution: [Int]) -> [[Int]] {

    		var moves: [[Int]] = [[]]

    		for i in 0..<items.count {
    				if !solution.contains(i) {
    						var move = solution
    						move.append(i)
    						if getWeightOfSolution(solution: move) <= maxWeight {
    								moves.append(move)
    						}
    				}
    		}

    		for i in 0..<solution.count {
    				var move = solution
    				move.remove(at: i)
    				moves.append(move)
    		}

    		return moves
    }

    func solveSimulatedAnnealing(startTemp: Double, endTemp: Double, steps: Int, eqSteps: Int) -> Int {

    		let alpha = (startTemp - endTemp) / Double(steps)
    		var currentTemp = startTemp

    		var bestSolution: [Int] = [] 
    		// bestSolution = generateRandomInitialSolution()
    		var bestValue = getValueOfSolution(solution: bestSolution)
    		var currentSolution = bestSolution

    		while currentTemp > endTemp {

    				// print(currentTemp)

    				for _ in 0..<eqSteps {
    						let moves = generateAllMovesForSolution(solution: currentSolution)
    						let randomIndex = Int(arc4random_uniform(UInt32(moves.count-1)))
    						let selectedMove = moves[randomIndex]
    						let delta = getValueOfSolution(solution: selectedMove) - bestValue

    						if delta > 0 {
    								bestSolution = selectedMove
    								bestValue = getValueOfSolution(solution: bestSolution)
    								currentSolution = bestSolution
    						} else {
    								if exp(Double(delta) / currentTemp) > (Double(arc4random()) / Double(UINT32_MAX)) {
    										currentSolution = selectedMove
    								}
    						}
    				}

    				currentTemp -= alpha
    		}

    		// print(bestSolution)
    		// print("MaxWeight: \(maxWeight)")
    		// print("SolutionWeight: \(getWeightOfSolution(solution: bestSolution))")
    		// print("SolutionValue: \(getValueOfSolution(solution: bestSolution))")

    		return bestValue
		}

}