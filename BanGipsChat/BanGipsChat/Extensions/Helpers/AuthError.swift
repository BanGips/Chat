//
//  AuthError.swift
//  BanGipsChat
//
//  Created by BanGips on 29.01.21.
//

import Foundation

enum AuthError {
    case notFailled
    case invalidEmail
    case passwordNotMathced
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFailled:
            return NSLocalizedString("заполните все понял", comment: "")
        case .invalidEmail:
            return NSLocalizedString("неверный формат почты", comment: "")
        case .passwordNotMathced:
            return NSLocalizedString("пароли не совпадают", comment: "")
        case .unknownError:
            return NSLocalizedString("неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("ошибка сервера", comment: "")
        }
    }
}
