//
//  ScoreVC.swift
//  hangmanGame
//
//  Created by Daria Sechko on 14.12.22.
//

import UIKit

class ScoreVC: UIViewController {
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        
        tableView.register(ScoreCell.self, forCellReuseIdentifier: ScoreCell.reuseId)
        
        return tableView
    }()
    
    lazy var homeBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "house")
        let button = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(homeBarButtonAction))
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = homeBarButton
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Actions
    
    @objc
    func homeBarButtonAction() {
        let mainVC = ScreenFactoryImpl().makeMainScreenViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
//MARK: - UITableViewDataSource
extension ScoreVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Score.shared.game.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.reuseId, for: indexPath) as? ScoreCell else { return UITableViewCell() }
        
       let session = Score.shared.game[indexPath.row]
        
        cell.dateLabel.text = "\(session.date)"
        cell.scoreLabel.text = "\(session.score)"
        
        return cell
    }
}
