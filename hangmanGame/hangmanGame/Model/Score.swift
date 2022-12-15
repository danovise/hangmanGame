//
//  Score.swift
//  hangmanGame
//
//  Created by Daria Sechko on 14.12.22.
//

import Foundation

class Score {
    
    static var shared = Score()
    
    private let scoreArchiver = ScoreArchiver()
    
    private(set) var game: [GameResponse] {
        didSet {
            scoreArchiver.saveSession(session: game)
        }
    }
    private init() {
        game = scoreArchiver.loadSession() ?? []
    }
    
    func addSession(session: GameResponse) {
        game.append(session)
    }
    
    func clearSession() {
        game.removeAll()
    }
}
