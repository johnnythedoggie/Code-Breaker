//
//  MastermindGradeUI.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import SwiftUI

struct MastermindGradeUI: View {
	
	let grade: MastermindGrade?
	
    var body: some View {
		
		VStack {
			
			Spacer()
			
			Text(grade.map { String($0.correctPlacement) } ?? "-")
				.foregroundColor(MastermindColors.correctPlacementTextColor)
			
			Text(grade.map { String($0.incorrectPlacement) } ?? "-")
				.foregroundColor(MastermindColors.incorrectPlacementTextColor)
			
			Spacer()
			
		}
		.bold()
		.frame(width: MastermindUIConstants.gradingBarWidth)
		.gridCellUnsizedAxes(.vertical)
		
    }
	
}

//	struct MastermindGradeUI_Previews: PreviewProvider {
//		static var previews: some View {
//			MastermindGradeUI()
//		}
//	}
