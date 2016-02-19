//
//  AppDelegate.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import UIKit
import ChameleonFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBar: UITabBarController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let browse = UINavigationController()
        browse.viewControllers = [BrowseController()]
        browse.tabBarItem = UITabBarItem(title: "Browse Colleges", image: UIImage(named: "Browse"), tag: 1)

        let search = UINavigationController()
        search.viewControllers = [SearchMenuViewController()]
        search.tabBarItem = UITabBarItem(title: "Search Colleges", image: UIImage(named: "Search"), tag: 3)

        
        let saved = UINavigationController()
        saved.viewControllers = [SavedViewController()]
        saved.tabBarItem = UITabBarItem(title: "Saved Colleges", image: UIImage(named: "Archive"), tag: 2)
        
        let settings = UINavigationController()
        settings.viewControllers = [SettingsVC()]
        settings.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.More, tag: 4)
        
        tabBar = UITabBarController()
        tabBar.viewControllers = [browse, search, saved, settings]
        
        self.window!.rootViewController = tabBar
        self.window!.makeKeyAndVisible()
        
        Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatPurpleColorDark(), withContentStyle: UIContentStyle.Contrast)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

