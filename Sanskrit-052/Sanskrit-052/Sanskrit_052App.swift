//
//  Sanskrit_052App.swift
//  Sanskrit-052
//
//  Created by Maleesha Wijeratne on 22/09/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore


@main
struct Sanskrit_052App: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
   
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate :NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
