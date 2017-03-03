//
//  AppDelegate.swift
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 03/02/17.
//  Copyright © 2016 Dark Matter LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        MTCallManager.shared().disableAudio();
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        MTCallManager.shared().restoreAudio();
    }

}
