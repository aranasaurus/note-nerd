//
//  Note.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

struct Note {
    enum Root: String {
        case A
        case B
        case C
        case D
        case E
        case F
        case G

        var value: Int {
            switch self {
            case .A: return 0
            case .B: return 2
            case .C: return 3
            case .D: return 5
            case .E: return 7
            case .F: return 8
            case .G: return 10
            }
        }
    }

    enum Accidental: String {
        case sharp = "♯"
        case flat = "♭"
    }

    let ordinal: Int
    var ascending: Bool

    var root: Root {
        switch ordinal {
        case 0: return .A
        case 1: return ascending ? .A : .B
        case 2: return .B
        case 3: return .C
        case 4: return ascending ? .C : .D
        case 5: return .D
        case 6: return ascending ? .D : .E
        case 7: return .E
        case 8: return .F
        case 9: return ascending ? .F : .G
        case 10: return .G
        case 11: return ascending ? .G : .A
        default: fatalError()
        }
    }

    var accidental: Accidental? {
        switch ordinal {
        case 0, 2, 3, 5, 7, 8, 10: return nil
        case 1, 4, 6, 9, 11: return ascending ? .sharp : .flat
        default: fatalError()
        }
    }
    
    var name: String {
        return root.rawValue + (accidental?.rawValue ?? "")
    }

    init(ordinal: Int, ascending: Bool = true) {
        self.ordinal = Note.calcOrdinal(ordinal)
        self.ascending = ascending
    }
    
    init?(string: String) {
        guard let letter = string.first,
            let root = Root(rawValue: String(letter).uppercased())
            else { return nil }

        let accidentalValue: Int
        if let accidentalChar = string.last, let accidental = Accidental(rawValue: String(accidentalChar)) {
            self.ascending = accidental == .sharp
            accidentalValue = accidental == .sharp ? 1 : -1
        } else {
            self.ascending = true
            accidentalValue = 0
        }

        let ordinal = root.value + accidentalValue
        self.ordinal = Note.calcOrdinal(ordinal)
    }

    func applying(_ operation: Operation) -> Note {
        switch operation {
        case .add(let interval):
            return Note(ordinal: ordinal + Int(interval), ascending: ascending)
        case .sub(let interval):
            return Note(ordinal: ordinal - Int(interval), ascending: ascending)
        }
    }
}

extension Note: Equatable {
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.ordinal == rhs.ordinal
    }
}

// MARK: Static Methods
extension Note {
    static func calcOrdinal(_ ordinal: Int) -> Int {
        var ordinal = ordinal
        while ordinal < 0 {
            ordinal += 12
        }
        return ordinal % 12
    }

    static func random() -> Note {
        let note = Note(ordinal: Int.random(in: 0..<12), ascending: Bool.random())
        return note
    }
}
