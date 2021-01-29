//
//  LoginViewController.swift
//  BanGipsChat
//
//  Created by BanGips on 21.01.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Welcome Back!", font: .avenir26())
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark())
    let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing Up", for: .normal)
        button.titleLabel?.font = .avenir20()
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(.buttonRed(), for: .normal)
        return button
    }()
    
    weak var delegate: AuthNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupConstraints()
        googleButton.customizeGoogleButton()
        
        loginButton.addTarget(self, action: #selector(liginButtonTapped), for: .touchUpInside)
        singUpButton.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func singUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSingUpVC()
        }
    }

    @objc private func liginButtonTapped() {
        AuthService.shared.login(email: emailTextField.text, password: passwordTextField.text) { (result) in
            switch result {
            case .success(let user):
                self.showAlert(with: "success", and: "you are autorise") {
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let mUser):
                            self.present(MainTabBarController(), animated: true)
                        case .failure(let error):
                            self.present(SetupProfileViewController(currentUser: user), animated: true)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "failure", and: error.localizedDescription)
            }
        }
    }
}

extension LoginViewController {
    
    private func setupConstraints() {
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spasing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spasing: 0)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [loginWithView,
                                                       orLabel,
                                                       emailStackView,
                                                       passwordStackView,
                                                       loginButton],
                                    axis: .vertical, spasing: 40)
        
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, singUpButton], axis: .horizontal, spasing: 0)
        bottomStackView.distribution = .fillEqually
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
    }
}


// MARK: - SwiftUI
import SwiftUI

struct LoginPControllerProvider: PreviewProvider {
    
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        }
    }
    
    
}
