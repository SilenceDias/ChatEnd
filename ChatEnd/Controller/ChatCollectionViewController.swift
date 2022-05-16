//
//  ChatCollectionViewController.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChatCollectionViewController: UICollectionViewController {

    private let user: UserModel
    private var messages = [MessageModel]()
    var fromCurrentUser = false
    
    private lazy var custominputView: CustomInputView = {
        let inputView = CustomInputView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        inputView.delegate = self
        return inputView
    }()
    
    init(user: UserModel){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessages()
    }
   
    override var inputAccessoryView: UIView? {
        get {return custominputView }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func fetchMessages(){
        Service.fetchMessages(forUser: user){
            messages in self.messages = messages
            self.collectionView.reloadData()
        }
    }
    func configureUI(){
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
        collectionView.register(MessageCellView.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        
    }

}
extension ChatCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  reuseIdentifier, for: indexPath) as! MessageCellView
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
}
extension ChatCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
extension ChatCollectionViewController: CustomInputViewDelegate{
    func inputView(_ inputView: CustomInputView, wantsToSend message: String) {
        
        Service.uploadMessages(message, to: user) { error in
            if let error = error{
                print("ERROR!!!")
                return
            }
            inputView.messageText.text = nil
        }
    }
    
    
}
