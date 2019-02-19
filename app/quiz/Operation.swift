//
//  Operation.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

enum Operation {
    case add(UInt)
    case sub(UInt)

    static func random() -> Operation {
        let n = UInt.random(in: 0..<12)
        return Bool.random() ? .add(n) : .sub(n)
    }
}
