//
//  MainViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import UIKit
import Firebase

private let reuseIdentifier = "userCell"

protocol NewMessageViewControllerDelegate: AnyObject {
    func controller(_ controller: MainViewController, chooseClub club: ClubModel)
}

class MainViewController: UITableViewController {

    private var clubs = [ClubModel]()
    weak var delegate: NewMessageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        authenticateUser()
        fetchUser()
      
    }
    func configureUi(){
        configureNavigationBar(withTitle: "Clubs", prefersLargeTitles: true)
        tableView.tableFooterView = UIView()
        tableView.register(ClubTableViewCell.self, forCellReuseIdentifier: reuseIdentifier )
        tableView.rowHeight = 80
        let image = UIImage(systemName: "person.circle.fill")
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
    }
    func fetchUser(){
        Service.fetchClubs { clubs in
            self.clubs = clubs
            self.tableView.reloadData()
        }
    }
    @objc func showProfile(){
        let controller = ProfileViewController(style: .insetGrouped)
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

  
}
extension MainViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath ) as! ClubTableViewCell
        cell.club = clubs[indexPath.row]
        return cell
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let controller = DetailedClubViewController(club: clubs[indexPath.row])
       let nav = UINavigationController(rootViewController: controller)
       nav.modalPresentationStyle = .fullScreen
       present(nav, animated: true, completion: nil)
       
    }
}
extension MainViewController: ProfileViewControllerDelegate{
    func handleLogout() {
        
        logout()
    }
}
