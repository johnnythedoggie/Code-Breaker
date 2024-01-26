//
//  Game.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import Foundation

struct MastermindGame {
	
	// The maximum allowable cell value for this game
	// Cell values start at 0
	// The total number of cell values will be one more than this value
	let maxCellValue: Int
	
	// The maximum number of rows for this game, if any
	let maxRows: Int?
	
	// The number of spaces to fill in each row.
	// Also the length of every MastermindRow used in this instance.
	let spacesPerRow: Int
	
	// The row that the user is trying to guess.
	let secretRow: CompleteMastermindRow
	
	// All the previous guesses in this game.
	private(set) var previousRows: [(num: Int, row: CompleteMastermindRow, grade: MastermindGrade)]
	
	// This is set by the UI to the user's selection.
	var currentRow: PartialMastermindRow
	
	var isGameOver: Bool {
		// if the last guess was correct, the game is over
		if let lastGuess = previousRows.last?.row, lastGuess == secretRow { return true }
		// if there is no maximum number of rows, the game isn't over
		guard let maxRows else { return false }
		// if there have been less than the maximum number of rows, the game is over
		return previousRows.count >= maxRows
	}
	
	var currentRowNum: Int? { hasCurrentRow ? previousRows.count : nil }
	
	private var futureRowNums: Range<Int>? {
		let currentRowOffset = hasCurrentRow ? 1 : 0
		guard let maxRows, (previousRows.count + currentRowOffset) < maxRows else { return nil }
		return (previousRows.count + currentRowOffset)..<maxRows
	}
	
	typealias MastermindRowInformation = (number: Int, row: PartialMastermindRow, grade: MastermindGrade?)
	
	var hasCurrentRow: Bool {
		return !isGameOver
	}
	
	var canSubmit: Bool {
		return hasCurrentRow && currentRow is CompleteMastermindRow
	}
	
	var rows: [MastermindRowInformation] {
		
		let previous: [MastermindRowInformation] = previousRows.map {
			($0.num, $0.row, $0.grade)
		}
		
		let current: [MastermindRowInformation] = hasCurrentRow ? [(currentRowNum!, currentRow, nil)] : []
		
		let future: [MastermindRowInformation] = futureRowNums?.map {
			($0, PartialMastermindRow(repeating: nil, count: spacesPerRow), nil)
		} ?? []
		
		return previous + current + future
		
	}
	
	
	// Submits currentRow as a guess, grades it, and sets it back to the empty row
	mutating func submitCurrentRow() {
		
		// be sure there are not too many rows already
		guard hasCurrentRow else { return }
		
		// be sure the row is complete
		guard let row = currentRow as? CompleteMastermindRow else { return }
		
		let grade = grade(for: row)
		let guessNumber = previousRows.count
		previousRows.append((num: guessNumber, row: row, grade: grade))
		currentRow = PartialMastermindRow(repeating: nil, count: spacesPerRow)
		
	}
	
	// Grades the row against the secretRow and returns the result
	private func grade(for row: CompleteMastermindRow) -> MastermindGrade {
		
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
