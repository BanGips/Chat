//
//  ActiveChatCell.swift
//  BanGipsChat
//
//  Created by BanGips on 23.01.21.
//

import UIKit
import Kingfisher

class ActiveChatCell: UICollectionViewCell {
    
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User Name", font: .laoSangamMN18())
    let lastMessage = UILabel(text: "How are you", font: .laoSangamMN18())
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.6656301167, green: 0.4784313738, blue: 0.6431372762, alpha: 1), endColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        setupConstraints()
        
        clipsToBounds = true
        layer.cornerRadius = 4
    }
    
    func configure(with value: MChat) {
        friendName.text = value.friendUsername
        lastMessage.text = value.lastMessage
        friendImageView.kf.setImage(with: URL(string: value.friendAvatarStringURL))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup constraints
extension ActiveChatCell {
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        friendImageView.backgroundColor = .brown
        gradientView.backgroundColor = .orange
        addSubview(friendImageView)
        addSubview(gradientView)
        addSubview(friendName)
        addSubview(lastMessage)
        
        friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        friendImageView.anchorConstantSize(size: 78)
        
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        gradientView.anchorWidthAndHeightSize(heightSize: 78, widthSize: 8)
        
        friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16).isActive = true
        friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16).isActive = true
        
        lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16).isActive = true
        lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16).isActive = true
        
    }
}
