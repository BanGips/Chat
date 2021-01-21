//
//  UIImageView + Extension.swift
//  BanGipsChat
//
//  Created by BanGips on 21.01.21.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
