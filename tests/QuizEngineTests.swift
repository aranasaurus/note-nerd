//
//  QuizEngineTests.swift
//  NoteNerdTests
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import XCTest

@testable import NoteNerd

class QuizEngineTests: XCTestCase {
    func testSubmit() {
        let engine = QuizEngine()
        let note = Note(ordinal: 9)
        engine.add(question:.init(note: note, op: .add(4)))
        XCTAssertFalse(engine.submit(note))
        XCTAssert(engine.submit(Note(ordinal: 13)))
        XCTAssertEqual(engine.answers.count, 1)
        XCTAssertEqual(engine.answers.first?.count, 2)
    }
}
