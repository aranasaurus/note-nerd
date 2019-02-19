//
//  Operation.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

enum Operation: CustomStringConvertible {
    var description: String {
        switch self {
        case let .add(interval):
            return "+ \(interval)"
        case let .sub(interval):
            return "- \(interval)"
        }
    }
    case add(UInt)
    case sub(UInt)

    static func random() -> Operation {
        // make the lower numbers happen more often by going over 12 but < 24
        let n = UInt.random(in: 1..<17)
        return Bool.random() ? .add(n) : .sub(n)
    }
}
