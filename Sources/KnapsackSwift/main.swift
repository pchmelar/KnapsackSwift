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
        for line in lines {
        		let problem = ProblemInstance(input: line)
        		//let bestValue = problem.solveBruteForce(n: problem.size-1, currentWeight: 0, currentValue: 0)
        		let bestValue = problem.solveHeuristic()
        		print("Best value of problem instance #\(problem.id) is \(bestValue)")
        }
    }
    catch {
    		print("Input file corrupted")
    }

}
