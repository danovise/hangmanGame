//
//  ScoreArchiver.swift
//  hangmanGame
//
//  Created by Daria Sechko on 14.12.22.
//

import Foundation

class ScoreArchiver {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "key"
    
    func saveSession(session: [GameResponse]) {
        do {
            let data = try encoder.encode(session)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadSession() -> [GameResponse]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([GameResponse].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
