//
//  AuthVC.swift
//  hangmanGame
//
//  Created by Daria Sechko on 12.12.22.
//

import UIKit
import FirebaseAuth
import SnapKit

enum AuthType: Int {
    case login
    case registration
}

class AuthVC: UIViewController {
    
    var authType: AuthType? = .login
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Авторизация"
        label.textColor = #colorLiteral(red: 0.8321632743, green: 0.4809746742, blue: 0.4813761115, alpha: 1)
        label.font = .systemFont(ofSize: 45, weight: .bold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = #colorLiteral(red: 0.9427779913, green: 0.8638927341, blue: 0.8610582948, alpha: 1)
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = #colorLiteral(red: 0.9427779913, green: 0.8638927341, blue: 0.8610582948, alpha: 1)
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    
    private let entryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8321632743, green: 0.4809746742, blue: 0.4813761115, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
       
        button.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let entryTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Зарегистроваться", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
        button.addTarget(self, action: #selector(entryTypeButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.text = "test@test.com"
        passwordTextField.text = "test123456789"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(entryButton)
        view.addSubview(entryTypeButton)
    }
    
    private func setupConstraints() {
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp_topMargin).inset(100)
            $0.centerX.equalTo(view.snp_centerXWithinMargins)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel).inset(100)
            $0.left.right.equalToSuperview().inset(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField).inset(60)
            $0.left.right.equalToSuperview().inset(50)
        }
        
        entryButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField).inset(60)
            $0.left.right.equalToSuperview().inset(50)
        }
        
        entryTypeButton.snp.makeConstraints {
            $0.top.equalTo(entryButton).inset(100)
            $0.left.right.equalToSuperview().inset(50)
        }
    }
    
    @objc
    private func entryButtonTapped() {
        switch authType {
        case .login:
            authorizeToFirebase()
        case .registration:
            registrationToFirebase()
        case .none:
            return
        }
    }
    
    @objc
    private func entryTypeButtonTapped() {
        switch authType {
        case .login:
            loginLabel.text = "Регистрация"
            entryButton.setTitle("Зарегистрироваться", for: .normal)
            entryTypeButton.setTitle("Уже есть аккаунт", for: .normal)
            authType = .registration
        case .registration:
            loginLabel.text = "Авторизация"
            entryButton.setTitle("Войти", for: .normal)
            entryTypeButton.setTitle("Зарегистрироваться", for: .normal)
            authType = .login
        case .none:
            return
        }
    }
    
    // MARK: - Navigation
    
    func showMainScreen() {
        let mainViewController = ScreenFactoryImpl().makeMainScreenViewController()
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func authorizeToFirebase() {
        Auth.auth().signIn(withEmail: "\(emailTextField.text ?? "")", password: "\(emailTextField.text ?? "")") { result, error in
            if let error = error {
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showMainScreen()
            }
        }
    }
    
    func registrationToFirebase() {
        Auth.auth().createUser(withEmail: "\(emailTextField.text ?? "")", password: "\(emailTextField.text ?? "")") { result, error in
            if result != nil {
                let alertController = UIAlertController(title: "", message: "Registration successful", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: {
                    self.entryTypeButtonTapped()
                })
            }
            if let error = error {
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }
    
    func logoutFromFirebase() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
