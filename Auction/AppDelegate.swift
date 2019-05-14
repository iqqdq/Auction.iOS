//
//  AppDelegate.swift
//  Auction
//
//  Created by Q on 18/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    ///------ Setup HHTabBarView ------///
    let hhTabBarView = HHTabBarView.shared
    let referenceUITabBarController = HHTabBarView.shared.referenceUITabBarController
    
    func setupReferenceUITabBarController() -> Void {
        let homeViewController = HomeRouter.createModule()
        let walletViewController = WalletRouter.createModule()
        let profileViewController = ProfileRouter.createModule()
        let settingsViewController = SettingsRouter.createModule()
        
        self.referenceUITabBarController.setViewControllers([homeViewController, walletViewController, profileViewController, settingsViewController], animated: false)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().shadowImage = UIImage()
        
        //Disable bottom scroll appearance views in Wallet tab
        UserDefaults.standard.removeObject(forKey: "viewDidScrolled")
        
        //Setup HHTabBarView
        self.setupReferenceUITabBarController()
        self.setupHHTabBarView()
        
        //Setup Application Window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: self.referenceUITabBarController)
        self.window!.rootViewController = navigationController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
//        //Show if has no logged in
//        if ((UserDefaults.standard.object(forKey: "token")) == nil) {
//            let authorizationViewController = AuthorizationRouter.createModule()
//            navigationController.pushViewController(authorizationViewController, animated: false)
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setupHHTabBarView() -> Void {
        //Create Custom Tabs
        //Note: As tabs are subclassed of UIButton so you can modify it as much as possible.
        let t1 = HHTabButton(withTitle: nil, tabImage: UIImage(named: "ic_tab_home"), index: 0)
        t1.setImage(UIImage(named: "ic_tab_home_blue"), for: .selected)
        t1.imageVerticalAlignment = .top
        t1.imageHorizontalAlignment = .center
        
        let t2 = HHTabButton(withTitle: nil, tabImage: UIImage(named: "ic_tab_wallet"), index: 1)
        t2.setImage(UIImage(named: "ic_tab_wallet_blue"), for: .selected)
        t2.imageVerticalAlignment = .top
        t2.imageHorizontalAlignment = .center
        
        let t3 = HHTabButton(withTitle: nil, tabImage: UIImage(named: "ic_tab_profile"), index: 2)
        t3.setImage(UIImage(named: "ic_tab_profile_blue"), for: .selected)
        t3.imageVerticalAlignment = .top
        t3.imageHorizontalAlignment = .center
        
        let t4 = HHTabButton(withTitle: nil, tabImage: UIImage(named: "ic_tab_settings"), index: 3)
        t4.setImage(UIImage(named: "ic_tab_settings_blue"), for: .selected)
        t4.imageVerticalAlignment = .top
        t4.imageHorizontalAlignment = .center
        
        //Set Default Index for HHTabBarView.
        self.hhTabBarView.tabBarTabs = [t1, t2, t3, t4]
        
        //You should modify badgeLabel after assigning tabs array.
        /*
         t1.badgeLabel?.backgroundColor = .white
         t1.badgeLabel?.textColor = selectedTabColor
         t1.badgeLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
         */
        
        //Handle Tab Change Event
        self.hhTabBarView.defaultIndex = 0
        
        //Show Animation on Switching Tabs
        self.hhTabBarView.tabChangeAnimationType = .none
        
        //Handle Tab Changes
        self.hhTabBarView.onTabTapped = { (tabIndex) in
            
        }
    }
    
    //MARK: Show/Hide HHTabBarView
    func hideTabBar() -> Void {
        self.hhTabBarView.isHidden = true
    }
    
    func showTabBar() -> Void {
        self.hhTabBarView.isHidden = false
    }
}

