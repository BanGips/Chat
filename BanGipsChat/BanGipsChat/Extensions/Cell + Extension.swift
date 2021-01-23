//
//  Cell + Extension.swift
//  BanGipsChat
//
//  Created by BanGips on 23.01.21.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(forType type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
}

