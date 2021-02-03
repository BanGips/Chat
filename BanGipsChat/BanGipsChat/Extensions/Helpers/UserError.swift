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
    case cannotGetUserInfo
    case cannotUnwrapToUser
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notField:
            return NSLocalizedString("Заполните все понял", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Юзер не выбрал фото", comment: "")
        case .cannotGetUserInfo :
            return NSLocalizedString("Невозможно загрузить инфу", comment: "")
        case .cannotUnwrapToUser:
            return NSLocalizedString("Невозможно конвертировать", comment: "")
        }
    }
}
