//
//  HowToPlayCell.swift
//  hangmanGame
//
//  Created by Daria Sechko on 13.12.22.
//

import UIKit

class HowToPlayCell: UITableViewCell {
    
    static var reuseId = "HowToPlayCell"
    
    lazy var titleLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.8321632743, green: 0.4809746742, blue: 0.4813761115, alpha: 1)
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var rulesLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.8465864062, green: 0.6757629514, blue: 0.6532330513, alpha: 1)
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20)
        
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(rulesLabel)
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            
            $0.top.left.right.equalTo(contentView).inset(10)
            $0.bottom.equalTo(rulesLabel.snp.top)
        }
        
        rulesLabel.snp.makeConstraints {
            $0.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
}
