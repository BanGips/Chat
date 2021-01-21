//
//  OneLineTextField.swift
//  BanGipsChat
//
//  Created by BanGips on 21.01.21.
//

import UIKit

class OneLineTextField: UITextField {
    
    convenience init(font: UIFont? = .avenir20()) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomView = UIView()
        bottomView.backgroundColor = .textFieldLight()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
