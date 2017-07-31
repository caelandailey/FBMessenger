//
//  CustomTabBarController.swift
//  FBMessenger
//
//  Created by Caelan Dailey on 7/30/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
               
        viewControllers = [recentMessagesNavController, createDummyNavConrollerWithTitle(title: "Calls", imageName: "calls"),createDummyNavConrollerWithTitle(title: "Groups", imageName: "groups"),createDummyNavConrollerWithTitle(title: "People", imageName: "people"), createDummyNavConrollerWithTitle(title: "Settings", imageName: "settings")]
        
        
    }
    
    private func createDummyNavConrollerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
