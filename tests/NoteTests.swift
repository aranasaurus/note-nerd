//
//  NoteTests.swift
//  NoteNerdTests
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import XCTest

@testable import NoteNerd

class NoteTests: XCTestCase {
    func testEquatable() {
        XCTAssertEqual(Note(ordinal: 0, ascending: true), Note(ordinal: 0, ascending: false))
        XCTAssertEqual(Note(ordinal: 9, ascending: true), Note(ordinal: 9, ascending: false))
        XCTAssertEqual(Note(ordinal: 12), Note(ordinal: 0))
    }

    func testInitWithString() {
        let a = Note(ordinal: 0)
        let aSharp = Note(ordinal: 1, ascending: true)
        let bFlat = Note(ordinal: 1, ascending: false)

        XCTAssertEqual(aSharp, bFlat)
        XCTAssertNotEqual(a, aSharp)

        XCTAssertEqual(a, Note(string: "A"))
        XCTAssertEqual(a, Note(string: "a"))
        XCTAssertNotEqual(a, Note(string: "A♯"))

        XCTAssertEqual(aSharp, Note(string: "A♯"))
        XCTAssertEqual(bFlat, Note(string: "A♯"))

        XCTAssertEqual(aSharp, Note(string: "B♭"))
        XCTAssertEqual(bFlat, Note(string: "B♭"))

        XCTAssertFalse(Note(string: "B♭")!.ascending)
        XCTAssertTrue(Note(string: "A♯")!.ascending)
        XCTAssertTrue(Note(string: "A♮")!.ascending)

        XCTAssertEqual(Note(string: "A♭")?.ordinal, 11)
        XCTAssertEqual(Note(string: "G♯")?.ordinal, 11)
    }

    func testName() {
        var note = Note(ordinal: 1, ascending: true)
        XCTAssertEqual(note.name, "A♯")
        note.ascending = false
        XCTAssertEqual(note.name, "B♭")

        note = Note(ordinal: 11)
        XCTAssertEqual(note.name, "G♯")
        note.ascending = false
        XCTAssertEqual(note.name, "A♭")

        note = Note(ordinal: 0)
        XCTAssertEqual(note.name, "A")
        note.ascending = false
        XCTAssertEqual(note.name, "A")
    }
}
