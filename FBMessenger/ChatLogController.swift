//
//  ChatLogController.swift
//  FBMessenger
//
//  Created by Caelan Dailey on 7/30/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            
            messages? = (friend?.messages?.allObjects as? [Message])!
            
            messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        
        cell.messageTextView.text = messages?[indexPath.item].text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
}

class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Sample message"
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
    }
}
