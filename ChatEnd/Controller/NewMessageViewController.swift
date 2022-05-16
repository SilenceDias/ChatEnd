//
//  NewMessageViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import UIKit

private let reuseIdentifier = "userCell"

protocol NewMessageViewControllerDelegate: class {
    func controller(_ controller: NewMessageViewController, wantsToStartChatWith user: UserModel)
}

class NewMessageViewController: UITableViewController {

    private var users = [UserModel]()
    weak var delegate: NewMessageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        fetchUser()
      
    }
    func configureUi(){
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handlerDismiss))
        tableView.tableFooterView = UIView()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: reuseIdentifier )
        tableView.rowHeight = 80
    }
    func fetchUser(){
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    @objc func handlerDismiss(){
        dismiss(animated: true, completion: nil)
    }

  
}
extension NewMessageViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath ) as! UserTableViewCell
        cell.user = users[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
    }
}
