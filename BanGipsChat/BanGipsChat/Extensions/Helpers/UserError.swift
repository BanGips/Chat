//
//  UserError.swift
//  BanGipsChat
//
//  Created by BanGips on 29.01.21.
//

import Foundation

enum UserError {
    case notField
    case photoNotExist
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notField:
            return NSLocalizedString("Заполните все понял", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Юзер не выбрал фото", comment: "")
        }
    }
}
