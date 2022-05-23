//
//  ProfileViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import UIKit
import Firebase

private let reuseIdentifier = "profileCell "

protocol ProfileViewControllerDelegate: AnyObject{
    func handleLogout()
}

class ProfileViewController: UITableViewController {
    
    private lazy var headerView = ProfileHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private let footerView  = ProfileFooterVIew()
    

    private var user: UserModel?{
        didSet{headerView.user = user}
    }
    weak var delegate: ProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        fetchUser()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            print("User is \(user.fullName)")
        }
    }
    func configureUi(){
        tableView.backgroundColor = .white
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(ProfileCellView.self, forCellReuseIdentifier: reuseIdentifier) 
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        footerView.delegate = self
        footerView.frame = .init(x: 0 , y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
    }

}
extension ProfileViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath ) as! ProfileCellView
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
extension ProfileViewController{
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else {return}
        switch viewModel {
        case .favorites:
            print("Show fav")
        case .settings:
            print("Show settings")
        }
    }
}
extension ProfileViewController: ProfileHeaderDelegate{
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
}
extension ProfileViewController: ProfileFooterDelegate{
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Do you want to logout?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}
