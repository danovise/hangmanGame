//
//  HowToPlayVC.swift
//  hangmanGame
//
//  Created by Daria Sechko on 13.12.22.
//

import UIKit

class HowToPlayVC: UIViewController {
    
    var rulesTitle = rulesResponse.gamesRulesTitle
    var rules = rulesResponse.gamesRules
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        
        tableView.register(HowToPlayCell.self, forCellReuseIdentifier: HowToPlayCell.reuseId)
        
        return tableView
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private
    
    private func setupViews() {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Играть", style: .plain, target: self, action: #selector(showGameScreen))
        
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Navigation
    
    @objc
    private func showGameScreen() {
        let gameVC = ScreenFactoryImpl().makeGameScreenViewController()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
    //MARK: - UITableViewDataSource

extension HowToPlayVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HowToPlayCell.reuseId, for: indexPath) as? HowToPlayCell else { return UITableViewCell() }
        
        cell.titleLabel.text = rulesTitle[indexPath.row]
        cell.rulesLabel.text = rules[indexPath.row]
        
        return cell
    }
}
