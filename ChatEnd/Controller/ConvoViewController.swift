//
//  ConvoViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 15.05.2022.
//

import UIKit
import Firebase
private let reuseIndentifier = "ChatCell"

class ConvoViewController: UIViewController {
    
    private let tableView = UITableView()
   
    private let newMessegeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font.withSize(20)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()  

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
    }
    
    @objc func showProfile(){
        logout()
    }
    @objc func showNewMessage(){
        let controller = NewMessageViewController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    func authenticateUser(){
        if Auth.auth().currentUser?.uid == nil{
            presentLoginScreen()
        }else{
            print("USER IS LOGGED IN")
        }
    }
    func logout(){
        do{
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("ERROR IN SIGNING OUT")
        }
    }
    func presentLoginScreen(){
        DispatchQueue.main.async {
            let controller = LoginViewController()
            let navigation = UINavigationController(rootViewController:  controller)
            navigation.modalPresentationStyle = .fullScreen 
            self.present(navigation, animated: true, completion: nil)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Chats", prefersLargeTitles: true)
        configureTableView()
        let image = UIImage(systemName: "person.circle.fill")
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessegeButton)
        newMessegeButton.setDimensions(height:  56, width: 56)
        newMessegeButton.layer.cornerRadius = 56 / 2
        newMessegeButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,  paddingBottom: 16, paddingRight: 24)
    }

    func configureTableView(){
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIndentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
   

}
extension ConvoViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath )
        cell.textLabel?.text = "Test Cell"
        return cell
    }
    
    
}

extension ConvoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row )
    }
}
extension ConvoViewController: NewMessageViewControllerDelegate{
    func controller(_ controller: NewMessageViewController, wantsToStartChatWith user: UserModel) {
        controller.dismiss(animated: true, completion: nil)
        let chat = ChatCollectionViewController(user: user)
        navigationController?.pushViewController(chat, animated: true)
    }
    
    
}
