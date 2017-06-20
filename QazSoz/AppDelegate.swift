//
//  AppDelegate.swift
//  QazSoz
//
//  Created by Yerbol Kopzhassar on 16/06/2017.
//  Copyright © 2017 Yerbol Kopzhassar. All rights reserved.
//

import UIKit
import Parse
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        parseSetUp()
        let mainVC = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        print(UIFont.familyNames)
        print(UIFont.fontNames(forFamilyName: "Helvetica Neue"))
        
        return true
    }
    func parseSetUp(){
        
        Parse.enableLocalDatastore()
        Parse.initialize( with: ParseClientConfiguration { (config: ParseMutableClientConfiguration) -> Void in
            config.applicationId = ParseSettings.applicationId
            config.clientKey = ParseSettings.clientKey
            config.server = ParseSettings.server
        })

    }

   

}

