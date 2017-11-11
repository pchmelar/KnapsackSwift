//
//  main.swift
//  KnapsackSwift
//
//  Created by Petr Chmelar on 24/10/2017.
//  Copyright © 2017 Petr Chmelar All rights reserved.
//

import Foundation

// parse arguments
if CommandLine.arguments.count == 3, let met = Int(CommandLine.arguments[2]), met > 0, met < 4 {

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
    print("Methods: 1 for bruteForce, 2 for heuristic, 3 for branchAndBound")
}
