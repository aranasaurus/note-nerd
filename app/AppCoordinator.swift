//
//  AppCoordinator.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/17/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import UIKit

class AppCoordinator {
    func startUp(in window: UIWindow) {
        let vc = QuizViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
