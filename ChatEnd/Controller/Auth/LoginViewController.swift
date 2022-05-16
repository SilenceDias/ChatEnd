//
//  LoginViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 15.05.2022.
//

import UIKit
import Firebase
import JGProgressHUD
class LoginViewController: UIViewController {
    private var viewModel = LoginViewModel()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(imageOf: UIImage(systemName: "envelope")!, textField: emailTextField)
    
    }()
    private lazy var passwordContainerView: UIView = {
        return InputContainerView(imageOf: UIImage(systemName: "lock")!, textField: passwordTextField)
    
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true  
        return textField
    }()
    private let noAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont have account?  ",attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI() 
        
    }
    @objc func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loging in"
        hud.show(in: view)
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR FAILED TO LOG IN\(error)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func handleShowSignUp(){
        let controller = RegisterViewController() 
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func textChanged(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        checkStatus()
    }
    func checkStatus(){
        if viewModel.formIsValid{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemRed
        }else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemPink
        }
    }
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 250, paddingLeft: 32, paddingRight: 32)
        view.addSubview(noAccountButton)
        noAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        emailTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

   

}
