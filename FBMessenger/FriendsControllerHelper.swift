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
            message.date = Date()
        
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve_profile"
        
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Apple creates great iOS Devices for the world..."
            messageSteve.date = Date()
            
            createMessageWithText("Good morning..", friend: steve, minutesAgo:  2, context: context)
            createMessageWithText("How are you?", friend: steve, minutesAgo:  1, context: context)
            createMessageWithText("Are you interested in buying an Apple Device", friend: steve, minutesAgo:  3, context: context)
        
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"
            
            createMessageWithText("You're fired!", friend: donald, minutesAgo: 60*5, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            createMessageWithText("Love, peace, and joy", friend: gandhi, minutesAgo: 60*24*2, context: context)
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary_profile"
            
            createMessageWithText("Love, peace, and joy", friend: hillary, minutesAgo: 60*24*12, context: context)
            
            
            do {
                try (context.save())
            } catch let error {
                print(error)
            }
            
        }
        loadData()
    }
    
    private func createMessageWithText(_ text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
    
        let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageSteve.friend = friend
        messageSteve.text = text
        messageSteve.date = Date().addingTimeInterval(-minutesAgo*60)
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            
            do {
                return try context.fetch(request) as? [Friend]
                
            } catch let error {
                print(error)
            }
            
        }
        return nil
    }
    
    // Fix later, random error???
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                
                messages = [Message]()
                
                for friend in friends {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchedMessages = try(context.fetch(fetchRequest)) as? [Message]
                        for message in fetchedMessages!
                        {
                            messages?.append(message)
                        }
                     
                    } catch let error {
                        print(error)
                    }
                }
                
                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
                
            }
            
            
            
            
            
            
        }
        
    }
    
}


