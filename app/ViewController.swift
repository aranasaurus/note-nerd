//
//  ViewController.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/17/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "Background")

        let label = UILabel(frame: view.frame)
        label.text = "I'm ALLIIIIIVVVEEEE!"
        label.textAlignment = .center
        view.addSubview(label)
    }
}

