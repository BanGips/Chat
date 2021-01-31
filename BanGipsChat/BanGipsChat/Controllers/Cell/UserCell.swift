//
//  UserCell.swift
//  BanGipsChat
//
//  Created by BanGips on 24.01.21.
//

import UIKit
import Kingfisher

class UserCell: UICollectionViewCell {
    
    let userImageView = UIImageView()
    let userNameLabel = UILabel(text: "text", font: .laoSangamMN20())
    let containerView = UIView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        layer.cornerRadius = 4
        backgroundColor = .white
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
    }
    
    private func setConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
    
        containerView.addSubview(userImageView)
        containerView.addSubview(userNameLabel)
        addSubview(containerView)
        
        containerView.fillSuperview()
        
        userImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        userImageView.trailingAnchor.constraint(equalTo: containerView .trailingAnchor).isActive = true
        userImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    func configure(with value: MUser) {
        userNameLabel.text = value.username
        guard let url = URL(string: value.avatarStringURL) else { return }
        userImageView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
