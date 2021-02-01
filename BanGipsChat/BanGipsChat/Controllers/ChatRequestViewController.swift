//
//  ChatRequestViewController.swift
//  BanGipsChat
//
//  Created by BanGips on 26.01.21.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar-4"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "PETER DAGGER", font: .systemFont(ofSize: 20, weight: .light))
    let aboutMeLabel = UILabel(text: "You have the opportunity to start a new chat", font: .systemFont(ofSize: 16, weight: .light))
    let acceptButton = UIButton(title: "ACCEPT", titleColor: .green, backgroundColor: .white, font: .laoSangamMN20(), isShadow: false, corenerRadius: 10)
    let denyButton = UIButton(title: "DENY", titleColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), backgroundColor: .white, font: .laoSangamMN20(), isShadow: false, corenerRadius: 10)
    
    private var chat: MChat
    
    weak var delegate: WaitingsChatNavigation?

    init(chat: MChat) {
        self.chat = chat
        nameLabel.text = chat.friendUsername
        imageView.kf.setImage(with: URL(string: chat.friendAvatarStringURL))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainWhite()
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        acceptButton.layer.borderWidth = 1.2
        acceptButton.layer.borderColor =  UIColor.green.cgColor
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .mainWhite()
        containerView.layer.cornerRadius = 30
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        
        denyButton.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
    }
    
    @objc private func denyButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @objc private func acceptButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.chatToActive(chat: self.chat)
        }
    }
    
}

extension ChatRequestViewController {
    
    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMeLabel)
        
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 206).isActive = true
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24).isActive = true
        
        aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spasing: 7)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        containerView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
    }
}


//// MARK: - SwiftUI
//import SwiftUI
//
//struct ChatRequestControllerProvider: PreviewProvider {
//
//    static var previews: some View {
//        Group {
//            ContainerView().edgesIgnoringSafeArea(.all)
//        }
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let viewController = ChatRequestViewController()
//
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
