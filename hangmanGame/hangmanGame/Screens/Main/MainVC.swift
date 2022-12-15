//
//  ViewController.swift
//  hangmanGame
//
//  Created by Daria Sechko on 12.12.22.
//

import UIKit

class MainVC: UIViewController {
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "hangmanLogo2")
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        return image
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.backgroundColor = #colorLiteral(red: 0.8321632743, green: 0.4809746742, blue: 0.4813761115, alpha: 1)
      //  button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        button.addTarget(self, action: #selector(showGameVC), for: .touchUpInside)
        
        return button
    }()
    
    private let scoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Score", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.backgroundColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
    //    button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        button.addTarget(self, action: #selector(showScoreVC), for: .touchUpInside)
        
        return button
    }()
    
    private let howToPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("How to play", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.backgroundColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
     //   button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        button.addTarget(self, action: #selector(showHowToPlayVC), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    // MARK: - Private
    
    private func setupViews() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        view.addSubview(logoImageView)
        view.addSubview(startButton)
        view.addSubview(scoreButton)
        view.addSubview(howToPlayButton)
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).inset(100)
           $0.left.right.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView).inset(220)
            $0.left.right.equalToSuperview().inset(50)
        }
        
        scoreButton.snp.makeConstraints {
            $0.top.equalTo(startButton).inset(100)
            $0.left.right.equalToSuperview().inset(50)
        }
        
        howToPlayButton.snp.makeConstraints {
            $0.top.equalTo(scoreButton).inset(100)
            $0.left.right.equalToSuperview().inset(50)
        }
    }
    // MARK: - Navigation
    
    @objc
    private func showGameVC() {
        let gameVC = ScreenFactoryImpl().makeGameScreenViewController()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc
    private func showScoreVC() {
        let scoreVC = ScreenFactoryImpl().makeScoreScreenViewController()
        self.navigationController?.pushViewController(scoreVC, animated: true)
    }
    
    @objc
    private func showHowToPlayVC() {
        let howToPlayVC = ScreenFactoryImpl().makeHowToPlayScreenViewController()
        self.navigationController?.pushViewController(howToPlayVC, animated: true)
    }
}
