//
//  main.swift
//  KnapsackSwift
//
//  Created by Petr Chmelar on 24/10/2017.
//  Copyright © 2017 Petr Chmelar All rights reserved.
//

import Foundation

// parse arguments
if CommandLine.arguments.count != 2 {
    print("Usage: KnapsackSwift inputFile")
} else {

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

        // solve with brute force
        var start = NSDate()
        for line in lines {
        		if line != "" {
        				let problem = ProblemInstance(input: line)
        				let bestValue = problem.solveBruteForce(n: problem.size-1, currentWeight: 0, currentValue: 0)
        				//print("Best value of problem instance #\(problem.id) is \(bestValue)")
        		}
        }
        print("Brute force method evaluation time: \(abs(start.timeIntervalSinceNow))")

        // solve with heuristic
        start = NSDate()
        for line in lines {
        		if line != "" {
        				let problem = ProblemInstance(input: line)
        				let bestValue = problem.solveHeuristic()
        				//print("Best value of problem instance #\(problem.id) is \(bestValue)")
        		}
        }
        print("Heuristic method evaluation time: \(abs(start.timeIntervalSinceNow))")
    }
    catch {
    		print("Input file corrupted")
    }

}
