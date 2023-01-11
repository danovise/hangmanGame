//
//  ScreenFactory.swift
//  hangmanGame
//
//  Created by Daria Sechko on 12.12.22.
//

import Foundation

protocol ScreenFactory {
    func makeAuthScreenViewController() -> AuthVC
    func makeMainScreenViewController() -> MainVC
    func makeGameScreenViewController() -> GameVC
    func makeScoreScreenViewController() -> ScoreVC
    func makeHowToPlayScreenViewController() -> HowToPlayVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    func makeAuthScreenViewController() -> AuthVC {
        let authVC = AuthVC()
        
        return authVC
    }
    
    func makeMainScreenViewController() -> MainVC {
        let mainVC = MainVC()
        
        return mainVC
    }
    
    func makeGameScreenViewController() -> GameVC {
        let gameVC = GameVC()
        
        return gameVC
    }
    
    func makeScoreScreenViewController() -> ScoreVC {
        let scoreVC = ScoreVC()
        
        return scoreVC
    }
    
    func makeHowToPlayScreenViewController() -> HowToPlayVC {
        let howToPlayVC = HowToPlayVC()
        
        return howToPlayVC
    }
}
