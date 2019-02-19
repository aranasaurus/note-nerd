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
        let n = UInt.random(in: 1..<7)
        return Bool.random() ? .add(n) : .sub(n)
    }
}
