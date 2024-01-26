//
//  MastermindGridUI.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import SwiftUI

struct MastermindGridUI: View {
	
	@Binding
	var game: MastermindGame
	
	@Binding
	var selectedCellValue: Int?
	
	init(_ game: Binding<MastermindGame>, _ selectedCellValue: Binding<Int?>) {
		self._game = game
		self._selectedCellValue = selectedCellValue
	}
	
	var body: some View {
		
		Grid(horizontalSpacing: 0, verticalSpacing: 0) {
			
			ForEach(game.rows, id: \.number) { (number, row, grade) in
				GridRow {
					MastermindRowUI(
						currentRow: $game.currentRow,
						selectedCellValue: $selectedCellValue,
						row: row,
						grade: grade,
						isCurrentRow: number == game.currentRowNum
					)
				}
			}
			
		}
		
	}
	
}

//	struct MastermindGridUI_Previews: PreviewProvider {
//		
//		static var previews: some View {
//			
//			let grade = MastermindGrade(
//				correctValueCorrectPlacement: 0,
//				correctValueIncorrectPlacement: 1
//			)
//			
//			let game = MastermindGame(
//				maxCellValue: 4,
//				maxRows: 10,
//				spacesPerRow: 4,
//				secretRow: [0, 1, 2, 3],
//				previousRows: [
//					(0, [3, 2, 2, 0], grade)
//				],
//				currentRow: [3, 2, nil, 0]
//			)
//			
//			MastermindGridUI(game: .constant(game))
//			
//		}
//		
//	}
