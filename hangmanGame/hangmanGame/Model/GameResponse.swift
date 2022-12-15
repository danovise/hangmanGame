//
//  GameResponse.swift
//  hangmanGame
//
//  Created by Daria Sechko on 14.12.22.
//

import Foundation

class GameResponse: Codable {
    var date: Date
    var score: Int
    
    init(date: Date, score: Int) {
        self.date = date
        self.score = score
    }
}
