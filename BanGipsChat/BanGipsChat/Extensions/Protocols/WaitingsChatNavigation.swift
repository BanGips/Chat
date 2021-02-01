//
//  WaitingsChatNavigation.swift
//  BanGipsChat
//
//  Created by BanGips on 1.02.21.
//

import Foundation

protocol WaitingsChatNavigation: class {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
