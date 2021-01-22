//
//  SegmentedControl + Extension.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit

extension UISegmentedControl {
    
    convenience init(first: String, second: String) {
        self.init()
        
        insertSegment(withTitle: first, at: 0, animated: true)
        insertSegment(withTitle: second, at: 1, animated: true)
        selectedSegmentIndex = 0
    }
}
