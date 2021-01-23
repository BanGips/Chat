//
//  SectionHeader.swift
//  BanGipsChat
//
//  Created by BanGips on 23.01.21.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    static let reuseID = "SectionHeader"

    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)

        title.fillSuperview()
    
    }

    func configure(text: String, font: UIFont?, textColor: UIColor) {
        title.textColor = textColor
        title.font = font
        title.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


