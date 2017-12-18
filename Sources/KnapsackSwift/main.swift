//
//  main.swift
//  KnapsackSwift
//
//  Created by Petr Chmelar on 24/10/2017.
//  Copyright © 2017 Petr Chmelar All rights reserved.
//

import Foundation

// parse arguments
if CommandLine.arguments.count >= 3, let met = Int(CommandLine.arguments[2]), met > 0, met < 7 {

		// determine full path of inputFile
		var fullPath = ""
		let inputPath = CommandLine.arguments[1]
		if inputPath.hasPrefix("/") {
				fullPath = inputPath
		} else {
				let cwd = FileManager.default.currentDirectoryPath
				let urlCwd = URL(fileURLWithPath: cwd)
    		if let path = URL(string: inputPath, relativeTo: urlCwd)?.path {
    				fullPath = path
    		}
		}

		// set options for simulated annealing
		var startTemp = 100.0
		var endTemp = 0.0
		var steps = 10
		var eqSteps = 100
		if met == 6 {
			if CommandLine.arguments.count >= 7, let arg1 = Double(CommandLine.arguments[3]), let arg2 = Double(CommandLine.arguments[4]), let arg3 = Int(CommandLine.arguments[5]), let arg4 = Int(CommandLine.arguments[6]) {
				startTemp = arg1
				endTemp = arg2
				steps = arg3
				eqSteps = arg4
			}
		}

		// read input file
    do {
        let inputFile = try String(contentsOf: URL(fileURLWithPath: fullPath), encoding: .utf8)
        let lines = inputFile.components(separatedBy: .newlines)

        let start = NSDate()
        for line in lines {
        		if line != "" {
        				let problem = ProblemInstance(input: line)

        				// solve with specified method
        				var bestValue: Int = 0
        				switch met {
        				case 1:
        						bestValue = problem.solveBruteForce(n: problem.size-1, currentWeight: 0, currentValue: 0)
        				case 2:
        						bestValue = problem.solveHeuristic()
        				case 3:
        						bestValue = problem.solveBranchAndBound(n: problem.size-1, currentWeight: 0, currentValue: 0, bestValue: 0)
        				case 4:
        						bestValue = problem.solveDecomposition()
        				case 5:
        						bestValue = problem.solveFPTAS()
        				case 6:
        						bestValue = problem.solveSimulatedAnnealing(startTemp: startTemp, endTemp: endTemp, steps: steps, eqSteps: eqSteps)
        				default:()
        				}
        				print("Best value of problem instance #\(problem.id) is \(bestValue)")
        		}
        }
        print("Evaluation time: \(abs(start.timeIntervalSinceNow))")
    }
    catch {
    		print("Input file corrupted")
    }

} else {
	  print("Usage: KnapsackSwift inputFile method")
    print("Methods: 1 for bruteForce, 2 for heuristic, 3 for branchAndBound, 4 for decomposition, 5 for FPTAS, 6 for simulatedAnnealing")
}
