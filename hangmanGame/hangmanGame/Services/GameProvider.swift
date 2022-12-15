////
////  GameProvider.swift
////  hangmanGame
////
////  Created by Daria Sechko on 12.12.22.
////
//
//import UIKit
//
//protocol GameProvider {
//    
//    var gameVC: GameVC { get set }
//    
//    var letters: [String] { get set }
//    
//    var words: [String] { get set }
//    
//    var choosenWord: String { get set }
//    
//    var supportedLanguages: [String] { get set }
//    
//    var unknownWord: String { get set }
//    
//    var hangmanImage: [String] { get set }
//    
//    var attempts: Int { get set }
//    
//    var score: Int { get set }
//    
//    func loadWords(language: String)
//    
//    func startGame()
//    
//    func changeCryptedWord(letter: String) -> String
//    
//    
//}
//
//class GameProviderImpl: GameProvider {
//    
//    static let shared = GameProviderImpl()
//    
//    var gameVC: GameVC
//    
//    init(gameVC: GameVC) {
//        self.gameVC = gameVC
//    }
//    
//    var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map({ String($0) })
//    var words = [String]()
//    var choosenWord: String = "silkworm"
//    
//    var supportedLanguages = ["English", "Russian"]
//    
//    var unknownWord = "" {
//        didSet {
//            gameVC.wordTextField.text = unknownWord
//        }
//    }
//    
//    var hangmanImage = [String]()
//    
//    var attempts = 0 { //попытки
//        didSet {
//            if let image = UIImage(named: "\(attempts).png") {
//                gameVC.hangmanImageView.image = image
//            } else {
//                gameVC.showAlert(title: "Game over!", message: "The word was: \(choosenWord.lowercased())")
//                score -= 1
//                startGame()
//            }
//        }
//    }
//    
//    var score = 0 {
//        didSet {
//            gameVC.scoreLabel.text = "Score: \(score)"
//        }
//    }
//    
//    @objc func loadWords(language: String) {
//        if let wordsUrl = Bundle.main.url(forResource: language, withExtension: "txt") {
//            if let wordsString = try? String(contentsOf: wordsUrl) {
//                words = wordsString.components(separatedBy: "\n")
//            }
//        }
//        
//        if words.isEmpty {
//            words.append("silkworm")
//        }
//        
//        startGame()
//     //   performSelector(onMainThread: #selector(startGame), with: nil, waitUntilDone: false)
//    }
//    
//    @objc func startGame() {
//        choosenWord = words.remove(at: words.indices.randomElement()!)
//        unknownWord = ""
//        attempts = 0
//            
//        gameVC.setupButtons()
//            
//        for _ in choosenWord {
//            unknownWord += "*"
//        }
//    }
//    
//    func changeCryptedWord(letter: String) -> String {
//        var cryptedArray = Array(unknownWord)
//        
//        for (i, item) in choosenWord.enumerated() {
//            if String(item).lowercased() == letter {
//                cryptedArray[i] = Character(letter.uppercased())
//            }
//        }
//        return String(cryptedArray)
//    }
//
//
//}
//
