//
//  FriendsControllerHelper.swift
//  FBMessenger
//
//  Created by Caelan Dailey on 7/29/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import UIKit
import CoreData
import Foundation

extension FriendsController {
    
    func clearData(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = delegate.persistentContainer.viewContext
        do{
            let entityNames = ["Friend", "Message"]
            for entityName in entityNames{
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
                let objects = try (context.fetch(fetchRequest))
                for object in objects{
                    context.delete(object)
                }
            }
            try (context.save())
        } catch let error{
            print(error)
        }
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
        
        
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        
       
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
        
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hey, nice to meet you!"
            message.date = NSDate()
        
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve_profile"
        
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Apple creates great iOS Devices for the world..."
            messageSteve.date = NSDate()
        
            
            do {
                try (context.save())
            } catch let error {
                print(error)
            }
            
        }
        loadData()
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            
            do {
                messages = try (context.execute(fetchRequest)) as? [Message]
            } catch let error {
                print(error)
            }
            
            
        }
        
    }
    
}


