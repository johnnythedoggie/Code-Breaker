//
//  VariableDifficultyMastermind.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/18/23.
//

import Foundation

// change to a struct at some point i assume
enum VariableDifficultyMastermind {
	
	static let difficulty: Double = 0.5
	
	static let lengthOfRow = 5
	static let numberOfPossibleColors = 5
	static let premadeArray = [Int](repeating: 0, count: numberOfPossibleColors)
	
	static func getAllRows(length: Int = lengthOfRow) -> [CompleteMastermindRow] {
		if length == 1 {
			return (0..<numberOfPossibleColors).map { [$0] }
		} else {
			let start = getAllRows(length: length - 1)
			return (0..<numberOfPossibleColors).flatMap { new in
				start.map { $0 + CollectionOfOne(new) }
			}
		}
	}
	
	static func test() {
		let rows = getAllRows()
		print()
		let start = Date.timeIntervalSinceReferenceDate
		for row1 in rows {
			var newLists: [MastermindGrade: [CompleteMastermindRow]] = [:]
			for row2 in rows {
				newLists[fastGrade(row1, row2), default: []].append(row2)
			}
			let list = newLists.map { (grade, list) in
				(grade, list.count)
			}.sorted(by: { $0.1 < $1.1})
			let gradeToGive = list[Int(Double(list.count) * difficulty)].0
			let nextRowList = newLists[gradeToGive]
		}
		let end = Date.timeIntervalSinceReferenceDate
		print((end - start) / Double(rows.count))
	}
	
	// My currently fastest grading algorithm
	static func fastGrade(_ first: CompleteMastermindRow, _ second: CompleteMastermindRow) -> MastermindGrade {
		
		var firstValueCounts = premadeArray
		var correctPlacement = 0
		var incorrectPlacement = 0
		
		for index in first.indices {
			if first[index] == second[index] {
				correctPlacement += 1
			} else {
				firstValueCounts[first[index]] += 1
			}
		}
		
		for value in second {
			if firstValueCounts[value] > 0 {
				incorrectPlacement += 1
				firstValueCounts[value] -= 1
			}
		}
		
		return MastermindGrade(
			correctPlacement: correctPlacement,
			incorrectPlacement: incorrectPlacement
		)
		
	}
	
	func slowGrade(_ secretRow: CompleteMastermindRow, _ row: CompleteMastermindRow) -> MastermindGrade {
		guard secretRow.count == row.count else {
			fatalError("The secret row and the row to grade have different lengths.")
		}
		
		// Step 1: Count the cells that match placement and value
		
		let correctPlacementCount = row.indices.filter { index in
			row[index] == secretRow[index]
		}.count
		
		// Step 2: Count the total number of matching value cells
		
		var totalMatchingCellCount = 0
		
		var rowIndex = 0
		var secretRowIndex = 0
		
		// this algorithm will only work if the lists are sorted
		let sortedRow = row.sorted()
		let sortedSecretRow = secretRow.sorted()
		
		// while the indicies are in bounds:
		// if they match, increment both indicies and add one to totalMatchingCellCount
		// otherwise, increment the index that corresponds to a smaller value
		while rowIndex < sortedRow.count, secretRowIndex < sortedSecretRow.count {
			
			let difference = sortedRow[rowIndex] - sortedSecretRow[secretRowIndex]
			
			switch difference {
			case 0:
				totalMatchingCellCount += 1
				rowIndex += 1
				secretRowIndex += 1
			case ...0:
				// sortedSecretRow[secretRowIndex] is bigger
				rowIndex += 1
			case 0...:
				// sortedRow[rowIndex] is bigger
				secretRowIndex += 1
			default:
				fatalError("Impossible possition reached.")
			}
			
		}
		
		// Step 3: Calculate and return the grade
		
		let incorrectPlacementCount = totalMatchingCellCount - correctPlacementCount
		
		return MastermindGrade(
			correctPlacement: correctPlacementCount,
			incorrectPlacement: incorrectPlacementCount
		)
	}
}
