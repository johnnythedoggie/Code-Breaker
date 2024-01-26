//
//  MastermindColorSelectorUI.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/18/23.
//

import SwiftUI

struct MastermindColorSelectorUI: View {
	
	@Binding
	var selectedCellValue: Int?
	
	init(_ selectedCell: Binding<Int?>) {
		self._selectedCellValue = selectedCell
	}
	
    var body: some View {
        
		ScrollViewReader { reader in
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 0) {
					
					ForEach([0, 1, 2, 3, 4, nil] as [Int?], id: \.self) { cellValue in
						
						let selected = (cellValue == selectedCellValue)
						
						MastermindCellUI(cell: cellValue, mode: selected ? .alwaysNotFlat : .alwaysFlat)
							.padding(.all, MastermindUIConstants.cellSpacing)
							.padding(.top, 5)
							.scaleEffect(selected ? 1.1 : 1.0)
							.onTapGesture {
								selectedCellValue = cellValue
							}
						
					}
					
				}.padding(.horizontal)
			}
			.onChange(of: selectedCellValue) { newSelection in
				withAnimation {
					reader.scrollTo(newSelection)
				}
			}
			.animation(.default, value: selectedCellValue)
		}
		.background { Color(.secondarySystemBackground) }
		
    }
	
}

//	struct MastermindColorSelectorUI_Previews: PreviewProvider {
//		static var previews: some View {
//			MastermindColorSelectorUI()
//		}
//	}
