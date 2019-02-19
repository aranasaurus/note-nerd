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
        engine.questions = [QuizEngine.Question(note: note, op: .add(4))]
        XCTAssert(engine.submit(Note(ordinal: 13)))
        XCTAssertFalse(engine.submit(note))
        XCTAssertEqual(engine.attempts, 2)
    }
}
