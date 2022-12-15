//
//  ScoreCell.swift
//  hangmanGame
//
//  Created by Daria Sechko on 14.12.22.
//

import UIKit

class ScoreCell: UITableViewCell {
    
    static let reuseId = "ScoreCell"
    
    var dateLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    var scoreLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func setupViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(scoreLabel)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints {
            
            $0.top.left.right.equalTo(contentView).inset(10)
            $0.bottom.equalTo(scoreLabel.snp.top)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
}
