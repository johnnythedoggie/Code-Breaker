//
//  MastermindRow.swift
//  Master Code Breaker
//
//  Created by Jason Turner on 8/17/23.
//

import Foundation

// A row of the mastermind game is a list of matermind cells.
typealias CompleteMastermindRow = [MastermindCell]
// If it is a partial row, there can be `nil`s in the list.
typealias PartialMastermindRow = [MastermindCell?]
