//
//  AppDelegate.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/17/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.coordinator = AppCoordinator()
        coordinator.startUp(in: window)

        return true
    }
}

