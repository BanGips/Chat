//
//  ProfileViewController.swift
//  BanGipsChat
//
//  Created by Sergey Kast on 24.01.21.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar-4"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "PETER DAGGER", font: .systemFont(ofSize: 20, weight: .light))
    let aboutMeLabel = UILabel(text: "fasfasfasfasfasfasfasffsdfsdfsdfsdfsdfsdfsdfsdfsdfafafaf", font: .systemFont(ofSize: 16, weight: .light))
    let myTextField = InsertableTextField()
    
    private let user: MUser
    
    override func loadView() {
        super.loadView()
        setupConstraints()
    }
    
    init(user: MUser) {
        self.user = user
        self.nameLabel.text = user.username
        self.aboutMeLabel.text = user.description
        self.imageView.kf.setImage(with: URL(string: user.avatarStringURL))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        customizeElements()
    }
    
    private func customizeElements() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        
        aboutMeLabel.numberOfLines = 0
        containerView.backgroundColor = .mainWhite()
        containerView.layer.cornerRadius = 30
        
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    @objc func sendMessage() {
        guard let message = myTextField.text, message != "" else { return }
        dismiss(animated: true) {
            FirestoreService.shared.createWaitingChat(message: message, resiever: self.user) { (result) in
                switch result {
                case .success():
                    UIApplication.getTopViewController()?.showAlert(with: "Success", and: "your message was has been sent")
                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(with: "Error", and: error.localizedDescription)
                }
            }
        }
     }
    
}

extension ProfileViewController {
    
    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMeLabel)
        containerView.addSubview(myTextField)
        
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
        
        myTextField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8).isActive = true
        myTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        myTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24).isActive = true
        myTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}

//// MARK: - SwiftUI
//import SwiftUI
//
//struct ProfileControllerProvider: PreviewProvider {
//
//    static var previews: some View {
//        Group {
//            ContainerView().edgesIgnoringSafeArea(.all)
//        }
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let viewController = ProfileViewController()
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
