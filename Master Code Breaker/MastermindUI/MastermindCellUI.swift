//
//  MastermindCellUI.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import SwiftUI

struct MastermindCellUI: View {
	
	let cell: Int?
	let mode: Mode
	
	var isFlat: Bool {
		switch mode {
		case .alwaysFlat:
			return true
		case .alwaysNotFlat:
			return false
		case .flatIfEmpty:
			return isEmpty
		}
	}
	
	var isEmpty: Bool {
		return cell == nil
	}
	
	enum Mode {
		case alwaysFlat
		case alwaysNotFlat
		case flatIfEmpty
	}
	
    var body: some View {
		
		let color = isEmpty
			? MastermindColors.emptyCellColor
			: MastermindColors.cellColors[cell!]
		
		let offset = isFlat ? 0 : MastermindUIConstants.cellElevation
		let strokeWidth = isEmpty ? 0 : MastermindUIConstants.cellBorderWidth
		
		let shape = RoundedRectangle(cornerRadius: MastermindUIConstants.cellCornerRadius)
		
		shape
			.foregroundColor(color)
			.aspectRatio(1.0, contentMode: .fill)
			.shadow(radius: 0, y: offset)
			.overlay {
				shape
					.stroke(lineWidth: strokeWidth)
					.foregroundColor(MastermindColors.cellBorderColor)
			}
			.overlay {
				if isEmpty {
					Image(systemName: "multiply")
						.opacity(0.2)
				}
			}
			.offset(y: -offset)
		
    }
	
}

//	struct MastermindCellUI_Previews: PreviewProvider {
//		static var previews: some View {
//			MastermindCellUI()
//		}
//	}
