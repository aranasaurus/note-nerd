//
//  QuizViewController.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/17/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    private let notes: UISegmentedControl = UISegmentedControl()
    private let accidentals: ToggleableSegmentedControl = ToggleableSegmentedControl()
    private let answerLabel: UILabel = UILabel()
    private let submit: UIButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "yellow")

        let questionLabel = UILabel()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "A + 3"
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(125)
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64)
        ])

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answerLabel)
        answerLabel.font = questionLabel.font.withSize(150)
        answerLabel.textAlignment = .center
        answerLabel.textColor = .white
        answerLabel.text = "?"
        answerLabel.shadowColor = UIColor(named: "pink")
        answerLabel.shadowOffset = CGSize(width: 3, height: 3)

        for (i, note) in "ABCDEFG".map(String.init).enumerated() {
            notes.insertSegment(withTitle: note, at: i, animated: false)
        }
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.tintColor = UIColor(named: "pink")
        notes.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 48)], for: .normal)
        notes.addTarget(self, action: #selector(answerChanged), for: .valueChanged)
        view.addSubview(notes)

        for (i, acc) in "♭♯".map(String.init).enumerated() {
            accidentals.insertSegment(withTitle: acc, at: i, animated: false)
        }
        accidentals.translatesAutoresizingMaskIntoConstraints = false
        accidentals.tintColor = UIColor(named: "pink")
        accidentals.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)], for: .normal)
        accidentals.addTarget(self, action: #selector(answerChanged), for: .valueChanged)
        view.addSubview(accidentals)

        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("GO!", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        submit.setTitleShadowColor(UIColor(named: "pink"), for: .normal)
        submit.titleLabel?.shadowOffset = CGSize(width: 3, height: 3)
        submit.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        submit.isEnabled = false
        view.addSubview(submit)

        NSLayoutConstraint.activate([
            answerLabel.centerYAnchor.constraint(equalTo: view.readableContentGuide.centerYAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),

            notes.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 32),
            notes.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            notes.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            notes.heightAnchor.constraint(equalToConstant: 56),

            accidentals.topAnchor.constraint(equalTo: notes.bottomAnchor, constant: 8),
            accidentals.leadingAnchor.constraint(equalTo: notes.leadingAnchor),
            accidentals.trailingAnchor.constraint(equalTo: notes.trailingAnchor),
            accidentals.heightAnchor.constraint(equalTo: notes.heightAnchor, multiplier: 0.66),

            submit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            submit.centerXAnchor.constraint(equalTo: view.readableContentGuide.centerXAnchor)
        ])
    }

    @objc private func answerChanged() {
        guard notes.selectedSegmentIndex != UISegmentedControl.noSegment else {
            answerLabel.text = "?"
            submit.isEnabled = false
            return
        }
        submit.isEnabled = true
        answerLabel.text = notes.titleForSegment(at: notes.selectedSegmentIndex)

        guard accidentals.selectedSegmentIndex != UISegmentedControl.noSegment,
            let accidental = accidentals.titleForSegment(at: accidentals.selectedSegmentIndex)
            else { return }

        answerLabel.text = answerLabel.text?.appending(accidental)
    }

    @objc private func checkAnswer() {
        // TODO: Imolement me
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
