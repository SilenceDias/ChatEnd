//
//  RegisterViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 15.05.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import JGProgressHUD

class RegisterViewController: UIViewController {
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    private let addPhoto: UIButton = {
        let button = UIButton(type: .system)
        let addImage = UIImage(named: "plus_photo")
        button.setImage(addImage, for: .normal)
        button.tintColor = .systemPink
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(imageOf: UIImage(systemName: "envelope")!, textField: emailTextField)
    
    }()
    private lazy var passwordContainerView: UIView = {
        return InputContainerView(imageOf: UIImage(systemName: "lock")!, textField: passwordTextField)
    
    }()
    private lazy var fullNameContainerView: InputContainerView = {
        return InputContainerView(imageOf: UIImage(systemName: "envelope")!, textField: fullNameTextField)
    
    }()
    private lazy var usernameContainerView: UIView = {
        return InputContainerView(imageOf: UIImage(systemName: "lock")!, textField: usernameTextField)
    
    }()
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullNameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleReg), for:  .touchUpInside)
        return button
    }()
    private let noAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have account?  ",attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
       
    }
    @objc func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    @objc func handleReg(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullNameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = profileImage else {return}
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Registering"
        hud.show(in: view)
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/prof_pictures/\(filename)")
        
        ref.putData(imageData , metadata: nil ){ (meta, error)  in
            if let error = error{
                print("DEBUG FAILED TO UPLOAD IMAGE WITH ERROR: \(error.localizedDescription)")
                return
            }
            ref.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: email, password:  password) { result, error in
                    if let error = error{
                        print("DEBUG FAILED TO CREATE USER WITH ERROR: \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    
                    let data = ["email": email,
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": username] as [String: Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data) { error in
                        if let error = error{
                            print("DEBUG FAILED TO CREATE USER  WITH ERROR: \(error.localizedDescription)")
                            return
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    @objc func textChanged(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == passwordTextField{
            viewModel.password = sender.text
        }
        else if sender == fullNameTextField{
            viewModel.fullname = sender.text
        }
        else{
            viewModel.username = sender.text
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
        view.backgroundColor = .white
        view.addSubview(addPhoto)
        addPhoto.centerX(inView: view)
        addPhoto.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        addPhoto.setDimensions(height: 200, width: 200)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, usernameContainerView, loginButton ])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: addPhoto.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        view.addSubview(noAccountButton)
        noAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        usernameTextField .addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

 
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        addPhoto.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhoto.layer.borderColor = UIColor.black.cgColor
        addPhoto.layer.borderWidth = 0.3
        addPhoto.layer.cornerRadius = 200 / 2
        addPhoto.imageView?.clipsToBounds = true
        addPhoto.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}
