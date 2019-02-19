//
//  QuizEngine.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

class QuizEngine {
    struct Question: CustomStringConvertible {
        let note: Note
        let op: Operation
        var result: Note { return note.applying(op) }

        var description: String {
            return "\(note.name) \(op)"
        }

        static func random() -> Question {
            var rng = SystemRandomNumberGenerator()
            return Question.random(using: &rng)
        }

        static func random<T: RandomNumberGenerator>(using generator: inout T) -> Question {
            let note = Note.random(using: &generator)
            let op = Operation.random(using: &generator)
            return Question(note: note, op: op)
        }
    }

    private(set) var questions = [Question]()
    private(set) var answers = [[Note]]()

    func add(question: Question) {
        questions.append(question)
        answers.append([])
    }

    func submit(_ answer: Note) -> Bool {
        guard let q = questions.last else { return false }

        let i = questions.endIndex.advanced(by: -1)
        var answers = self.answers[i]
        answers.append(answer)
        self.answers[i] = answers

        return answer == q.result
    }
}
