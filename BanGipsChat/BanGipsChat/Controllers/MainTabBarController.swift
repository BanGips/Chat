//
//  MainTabBarController.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let listViewController = ListViewController()
        let poepleViewController = PeopleViewController()
        
        tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2")!
        
        viewControllers = [generateNavigationController(rootVC: poepleViewController, title: "People", image: peopleImage),
                           generateNavigationController(rootVC: listViewController, title: "Conversation", image: convImage)]
    }
    
    private func generateNavigationController(rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
