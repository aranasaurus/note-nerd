//
//  QuizEngine.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

class QuizEngine {
    struct Question {
        let note: Note
        let op: Operation
        var result: Note { return note.applying(op) }
    }

    var questions = [Question]()
    var answers = [Note]()
    var attempts = 0

    func generate() -> Question {
        let q = Question(note: Note.random(), op: Operation.random())
        questions.append(q)
        return q
    }

    func submit(_ answer: Note) -> Bool {
        guard let q = questions.last else { return false }

        attempts += 1

        guard answer == q.result else { return false }

        answers.append(answer)
        return true
    }
}
