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
        var rng = SystemRandomNumberGenerator()
        return Operation.random(using: &rng)
    }

    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Operation {
        let n = UInt.random(in: 1..<7, using: &generator)
        return Bool.random(using: &generator) ? .add(n) : .sub(n)
    }
}
