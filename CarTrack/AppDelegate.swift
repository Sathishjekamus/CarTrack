//
//  AppDelegate.swift
//  CarTrack
//
//  Created by Helix Technical Services on 30/12/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyD0ChHBXodTnxN9XuhzcKNf_ptGDLv-73M")
        return true
    }

  


}

