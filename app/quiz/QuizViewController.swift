//
//  QuizViewController.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/17/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    private var rng = SystemRandomNumberGenerator()
    var engine: QuizEngine = QuizEngine()

    private let questionLabel: UILabel = UILabel()
    private let answerVC: AnswerViewController = AnswerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "yellow")

        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(125)
        questionLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(questionLabel)

        answerVC.delegate = self
        let answerView = answerVC.view!
        view.addSubview(answerView)
        addChild(answerVC)
        answerVC.didMove(toParent: self)

        answerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),

            answerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            answerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            answerView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            answerView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor)
        ])

        nextQuestion()
    }

    func nextQuestion() {
        let question = QuizEngine.Question.random(using: &rng)
        engine.add(question: question)

        questionLabel.text = question.description
        answerVC.reset(for: question)
    }
}

extension QuizViewController: AnswerViewControllerDelegate {
    func answerViewControllerDidSubmit(_ vc: AnswerViewController) {
        guard let note = vc.selectedNote else { return }

        if engine.submit(note) {
            let alert = UIAlertController(title: "Correct!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "🎉", style: .cancel, handler: { _ in
                self.nextQuestion()
            }))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "WRONG!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "😭", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}

private class ToggleableSegmentedControl: UISegmentedControl {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let previousSelectedIndex = selectedSegmentIndex
        super.touchesEnded(touches, with: event)

        guard previousSelectedIndex == selectedSegmentIndex,
            let touch = touches.first,
            bounds.contains(touch.location(in: self))
            else { return }

        selectedSegmentIndex = UISegmentedControl.noSegment
        sendActions(for: .valueChanged)
    }
}
