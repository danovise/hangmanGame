//
//  GameVC.swift
//  hangmanGame
//
//  Created by Daria Sechko on 13.12.22.
//

import UIKit

class GameVC: UIViewController {
    
    var hangmanImageView: UIImageView!
    var wordTextField: UITextField!
    var buttonsView: UIView!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    var selectedButton = [UIButton]()
    
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map({ String($0) })
    var words = [String]()
    var hangmanImage = [String]()
    var choosenWord: String = "silkworm"
    
    let supportedLanguages = ["English", "Russian"]
    
    var unknownWord = "" {
        didSet {
            wordTextField.text = unknownWord
        }
    }
    
    var attempts = 0 { //попытки
        didSet {
            if let image = UIImage(named: "\(attempts).png") {
                hangmanImageView.image = image
            } else {
                showAlert(title: "Игра закончена", message: "Загаданное слово: \(choosenWord.lowercased())")
                score -= 1
                Score.shared.addSession(session: GameResponse(date: Date(), score: score))
                startGame()
            }
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        loadWords(language: "english")
        startGame()
    }
    //MARK: - Setup View
    
    func setupViews() {
        // navigationItem.hidesBackButton = true
        view.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        
        hangmanImageView = UIImageView()
        hangmanImageView.translatesAutoresizingMaskIntoConstraints = false
        hangmanImageView.image = UIImage(named: "\(attempts).png")
        view.addSubview(hangmanImageView)
        
        wordTextField = UITextField()
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        wordTextField.isUserInteractionEnabled = false
        wordTextField.font = UIFont.systemFont(ofSize: 32)
        wordTextField.textColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
        wordTextField.textAlignment = .center
        view.addSubview(wordTextField)
        
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            hangmanImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            hangmanImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            hangmanImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            hangmanImageView.heightAnchor.constraint(equalTo: hangmanImageView.widthAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            wordTextField.topAnchor.constraint(equalTo: hangmanImageView.bottomAnchor, constant: 30),
            wordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40),
            wordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            buttonsView.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 20),
            buttonsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            buttonsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let height = 42
        let width = 80
        
        for row in 0..<6 {
            for col in 0..<4 {
                createButton(row: row, col: col, height: height, width: width)
            }
        }
        createButton(row: 6, col: 0, height: height, width: width)
        createButton(row: 6, col: 1, height: height, width: width)
    }
    
    func createButton(row: Int, col: Int, height: Int, width: Int) {
        let button = UIButton()
        button.setTitle(letters[row * 4 + col], for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
        
        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
        button.frame = frame
        buttonsView.addSubview(button)
        letterButtons.append(button)
    }
    
    @objc func letterButtonTapped(_ sender: UIButton) {
        selectedButton.append(sender)
        let letter = (sender.titleLabel?.text!.lowercased())!
        if choosenWord.lowercased().contains(letter) {
            sender.setTitleColor(.green.withAlphaComponent(0.5), for: .normal)
            unknownWord = changeCryptedWord(letter: letter)
            sender.isEnabled = false
        } else {
            sender.isHidden = true
            attempts += 1
        }
        
        if unknownWord.lowercased() == choosenWord.lowercased() {
            if words.isEmpty {
                showAlert(title: "Конец!", message: "Все слова использованы")
                for button in letterButtons {
                    // button.setTitleColor(.systemBlue, for: .normal)
                    button.isEnabled = false
                }
            } else {
                showAlert(title: "Победа!", message: "Переходим к следующему слову...")
                score += 1
                Score.shared.addSession(session: GameResponse(date: Date(), score: score))
                startGame()
            }
        }
    }
    
    func setupButtons() {
        selectedButton.removeAll()
        for button in letterButtons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.isEnabled = true
            button.isHidden = false
        }
    }
    //MARK: - Actions
    func startGame() {
        choosenWord = words.remove(at: words.indices.randomElement()!)
        unknownWord = ""
        attempts = 0
        
        setupButtons()
        
        for _ in choosenWord {
            unknownWord += "*"
        }
    }
    
     func loadWords(language: String) {
        if let wordsUrl = Bundle.main.url(forResource: language, withExtension: "txt") {
            if let wordsString = try? String(contentsOf: wordsUrl) {
                words = wordsString.components(separatedBy: "\n")
            }
        }
        
        if words.isEmpty {
            words.append("silkworm")
        }
        startGame()
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    func changeCryptedWord(letter: String) -> String {
        var cryptedArray = Array(unknownWord)
        
        for (i, item) in choosenWord.enumerated() {
            if String(item).lowercased() == letter {
                cryptedArray[i] = Character(letter.uppercased())
            }
        }
        return String(cryptedArray)
    }
    
}

//class GameVC: UIViewController {

//    var provider: GameProvider
//
//    var hangmanImageView: UIImageView!
//    var wordTextField: UITextField!
//    var buttonsView: UIView!
//    var scoreLabel: UILabel!
//    var letterButtons = [UIButton]()
//    var selectedButton = [UIButton]()
//
//    //MARK: - Lifecycle
//
//    init(gameProvider: GameProvider) {
//        self.provider = gameProvider
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//
//        provider.loadWords(language: "english")
//        provider.startGame()
//    }
//
//    func setupViews() {
//        view.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
//
//        hangmanImageView = UIImageView()
//        hangmanImageView.translatesAutoresizingMaskIntoConstraints = false
//        hangmanImageView.image = UIImage(named: "\(provider.attempts).png")
//        view.addSubview(hangmanImageView)
//
//        wordTextField = UITextField()
//        wordTextField.translatesAutoresizingMaskIntoConstraints = false
//        wordTextField.isUserInteractionEnabled = false
//        wordTextField.font = UIFont.systemFont(ofSize: 32)
//        wordTextField.textColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
//        wordTextField.textAlignment = .center
//        view.addSubview(wordTextField)
//
//        buttonsView = UIView()
//        buttonsView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(buttonsView)
//
//        scoreLabel = UILabel()
//        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
//        scoreLabel.text = "Score: \(provider.score)"
//        scoreLabel.textColor = .white
//        scoreLabel.textAlignment = .right
//        view.addSubview(scoreLabel)
//
//        NSLayoutConstraint.activate([
//            hangmanImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
//            hangmanImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
//            hangmanImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
//            hangmanImageView.heightAnchor.constraint(equalTo: hangmanImageView.widthAnchor),
//
//            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
//            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//
//            wordTextField.topAnchor.constraint(equalTo: hangmanImageView.bottomAnchor, constant: 30),
//            wordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40),
//            wordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40),
//
//            buttonsView.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 20),
//            buttonsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
//            buttonsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
//            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
//        ])
//
//        let height = 42
//        let width = 80
//
//        for row in 0..<6 {
//            for col in 0..<4 {
//                createButton(row: row, col: col, height: height, width: width)
//            }
//        }
//        createButton(row: 6, col: 0, height: height, width: width)
//        createButton(row: 6, col: 1, height: height, width: width)
//    }
//
//    func setupButtons() {
//        selectedButton.removeAll()
//        for button in letterButtons {
//            button.setTitleColor(.black, for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
//            button.setTitleColor(.white, for: .normal)
//            button.isEnabled = true
//            button.isHidden = false
//        }
//    }
//
//    func createButton(row: Int, col: Int, height: Int, width: Int) {
//        let button = UIButton()
//        button.setTitle(provider.letters[row * 4 + col], for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
//        button.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
//
//        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
//        button.frame = frame
//        buttonsView.addSubview(button)
//        letterButtons.append(button)
//    }
//
//    func showAlert(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alertController, animated: true)
//    }
//
//    @objc func letterButtonTapped(_ sender: UIButton) {
//        selectedButton.append(sender)
//        let letter = (sender.titleLabel?.text!.lowercased())!
//        if provider.choosenWord.lowercased().contains(letter) {
//            sender.setTitleColor(.green.withAlphaComponent(0.5), for: .normal)
//            provider.unknownWord = provider.changeCryptedWord(letter: letter)
//            sender.isEnabled = false
//        } else {
//            sender.isHidden = true
//            provider.attempts += 1
//        }
//
//        if provider.unknownWord.lowercased() == provider.choosenWord.lowercased() {
//            if provider.words.isEmpty {
//                showAlert(title: "End!", message: "All words are used")
//                for button in letterButtons {
//                   // button.setTitleColor(.systemBlue, for: .normal)
//                    button.isEnabled = false
//                }
//            } else {
//                showAlert(title: "You won!", message: "Next word ->")
//                provider.score += 1
//                provider.startGame()
//            }
//        }
//    }
//}
