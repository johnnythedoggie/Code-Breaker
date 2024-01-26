//
//  MastermindGameView.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import SwiftUI

struct MastermindGameView: View {
	
	@State
	var game: MastermindGame = MastermindGame(
		maxCellValue: 5,
		maxRows: 6,
		spacesPerRow: 4,
		secretRow: [1, 2, 2, 0],
		previousRows: [],
		currentRow: [nil, nil, nil, nil]
	)
	
	@State
	var selectedCellValue: Int? = 0
	
    var body: some View {
	
		VStack(spacing: 0) {
			
			ZStack(alignment: .bottomTrailing) {
				
				ScrollView {
					
					MastermindGridUI($game, $selectedCellValue)
						.animation(.easeOut, value: game.rows.map(\.row))
					
					Rectangle()
						.foregroundColor(Color(.systemBackground))
						.frame(height: 100)
					
				}
				
				Button(action: { game.submitCurrentRow() }) {
					RoundedRectangle(cornerRadius: 10)
						.foregroundColor(.blue)
						.frame(width: 100, height: 50)
						.overlay {
							Text("Submit")
								.foregroundColor(.black)
								.font(.title3)
								.bold()
						}
						.padding()
						.shadow(radius: 2, y: -1)
				}
				.opacity(game.canSubmit ? 1.0 : 0.7)
				.disabled(!game.canSubmit)
				
			}
			
			Rectangle()
				.foregroundColor(.black)
				.frame(height: 1)
			
			MastermindColorSelectorUI($selectedCellValue)
				.frame(height: 100)
				
		}.background {
			
			VStack {
				Color(.systemBackground)
				Color(.secondarySystemBackground)
			}.ignoresSafeArea()
			
		}
		
    }
	
}

struct MastermindGameView_Previews: PreviewProvider {
	static var previews: some View {
		MastermindGameView()
	}
}
