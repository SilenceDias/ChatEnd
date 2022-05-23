//
//  DetailedClubViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import UIKit

private let reuseIdentifier = "clubCell"
class DetailedClubViewController: UITableViewController {
    
    private var club: ClubModel?{
        didSet{headerView.club = club}
    }
    private lazy var headerView = ClubHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    
    init(club: ClubModel) {
        self.club = club
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        fetchClub()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func fetchClub(){
        guard let id = club?.id else { return}
        Service.fetchClub(withId: id) { club in
            self.club = club
            print("User is \(club.address)")
        }
    }
    func configureUi(){
        tableView.backgroundColor = .white
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(ClubDescriptionCellView.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
    }
    

   

}
extension DetailedClubViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClubViewModel.allCases.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath ) as! ClubDescriptionCellView
        let viewModel = ClubViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        return cell
    }
}
extension DetailedClubViewController{
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
extension DetailedClubViewController: ClubHeaderDelegate{
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
}
