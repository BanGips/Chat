//
//  WaitingChatCell.swift
//  BanGipsChat
//
//  Created by BanGips on 23.01.21.
//

import UIKit

class WaitingChatCell: UICollectionViewCell {
    
    let friendRequestImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setupConstraints()
    }
    
    func configure(with value: MChat) {
        friendRequestImageView.image = UIImage(named: "human1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WaitingChatCell {
    
    private func setupConstraints() {
        friendRequestImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendRequestImageView)
        
        friendRequestImageView.fillSuperview()
    }
}
