//
//  AddPhotoView.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit

class AddPhotoView: UIView {
    
    let circleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "avatar-4")
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let plusButton: UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .buttonDark()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(circleImageView)
        addSubview(plusButton)
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        
        circleImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circleImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        plusButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 16).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
