//
//  MastermindRowUI.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import SwiftUI

struct MastermindRowUI: View {
	
	@Binding
	var currentRow: PartialMastermindRow
	
	@Binding
	var selectedCellValue: Int?
	
	let row: PartialMastermindRow
	let grade: MastermindGrade?
	let isCurrentRow: Bool
	
	init(
		currentRow: Binding<PartialMastermindRow>,
		selectedCellValue: Binding<Int?>,
		row: PartialMastermindRow,
		grade: MastermindGrade?,
		isCurrentRow: Bool
	) {
		self._currentRow = currentRow
		self._selectedCellValue = selectedCellValue
		self.row = row
		self.grade = grade
		self.isCurrentRow = isCurrentRow
	}
	
    var body: some View {
	
		let cells = [(offset: Int, element: MastermindCell?)](row.enumerated())
		
		Group {
			
			ForEach(cells, id: \.offset) { (index, cellValue) in
				MastermindCellUI(cell: cellValue, mode: .flatIfEmpty)
					.gridCellColumns(1)
					.onTapGesture {
						if isCurrentRow {
							currentRow[index] = selectedCellValue
						} else {
							selectedCellValue = cellValue
						}
					}
			}
			.padding(.all, MastermindUIConstants.cellSpacing)
			
			MastermindGradeUI(grade: grade)
				.gridCellColumns(1)
			
		}.background(
			isCurrentRow
			? MastermindColors.currentRowBackgroundColor
			: MastermindColors.rowBackgroundColor
		)
		
    }
	
}

//	struct MastermindRowUI_Previews: PreviewProvider {
//		static var previews: some View {
//			MastermindRowUI()
//		}
//	}
