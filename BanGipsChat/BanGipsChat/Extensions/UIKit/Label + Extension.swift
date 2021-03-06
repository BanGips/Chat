//
//  Label + Extension.swift
//  BanGipsChat
//
//  Created by BanGips on 21.01.21.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
