//
//  AnswerViewController.swift
//  NoteNerd
//
//  Created by Ryan Arana on 2/20/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import UIKit

protocol AnswerViewControllerDelegate: class {
    func answerViewControllerDidSubmit(_ vc: AnswerViewController)
}

class AnswerViewController: UIViewController {
    weak var delegate: AnswerViewControllerDelegate?

    var ascending: Bool = true {
        didSet { selectedNote?.ascending = ascending }
    }

    var selectedNote: Note? {
        didSet { updateForSelectedNote() }
    }

    private let notes: UISegmentedControl = UISegmentedControl()
    private let accidentalButton: SelectableBGButton = SelectableBGButton()
    private let answerLabel: UILabel = UILabel()
    private let submitButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answerLabel)
        answerLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(150)
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
        notes.addTarget(self, action: #selector(updateAnswer), for: .valueChanged)
        view.addSubview(notes)

        accidentalButton.addTarget(self, action: #selector(accidentalButtonTapped), for: .touchUpInside)
        accidentalButton.translatesAutoresizingMaskIntoConstraints = false
        accidentalButton.tintColor = UIColor(named: "pink")
        accidentalButton.setTitleColor(UIColor(named: "pink"), for: .normal)
        accidentalButton.setTitleColor(UIColor(named: "yellow"), for: .selected)
        accidentalButton.selectedBGColor = UIColor(named: "pink")
        accidentalButton.normalBGColor = .clear
        accidentalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        accidentalButton.layer.borderColor = accidentalButton.tintColor.cgColor
        accidentalButton.layer.borderWidth = 1
        accidentalButton.layer.cornerRadius = 4
        accidentalButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.addSubview(accidentalButton)

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("GO!", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitleColor(view.backgroundColor, for: .disabled)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        submitButton.setTitleShadowColor(UIColor(named: "pink"), for: .normal)
        submitButton.setTitleShadowColor(view.backgroundColor, for: .disabled)
        submitButton.titleLabel?.shadowOffset = CGSize(width: 3, height: 3)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitButton.isEnabled = false
        view.addSubview(submitButton)

        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: view.topAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            notes.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 32),
            notes.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notes.trailingAnchor.constraint(equalTo: accidentalButton.leadingAnchor, constant: -8),
            notes.heightAnchor.constraint(equalToConstant: 56),

            accidentalButton.topAnchor.constraint(equalTo: notes.topAnchor),
            accidentalButton.bottomAnchor.constraint(equalTo: notes.bottomAnchor),
            accidentalButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        updateForSelectedNote()
    }

    func reset(for question: QuizEngine.Question) {
        selectedNote = nil
        ascending = question.note.ascending
        notes.selectedSegmentIndex = UISegmentedControl.noSegment
    }

    @objc private func submit() {
        delegate?.answerViewControllerDidSubmit(self)
    }

    @objc private func accidentalButtonTapped() {
        accidentalButton.isSelected.toggle()
        updateAnswer()
    }

    @objc private func updateAnswer() {
        guard notes.selectedSegmentIndex != UISegmentedControl.noSegment,
            let root = notes.titleForSegment(at: notes.selectedSegmentIndex)
            else {
                selectedNote = nil
                return
        }

        if accidentalButton.isSelected, let accidental = accidentalButton.titleLabel?.text {
            selectedNote = Note(string: root + accidental)
        } else {
            selectedNote = Note(string: root)
        }
    }

    private func updateForSelectedNote() {
        answerLabel.text = selectedNote?.name ?? "?"
        accidentalButton.setTitle(ascending ? Note.Accidental.sharp.rawValue : Note.Accidental.flat.rawValue, for: .normal)
        if selectedNote == nil {
            notes.selectedSegmentIndex = UISegmentedControl.noSegment
            accidentalButton.isSelected = false
        }
        submitButton.isEnabled = selectedNote != nil
    }
}

private class SelectableBGButton: UIButton {
    var selectedBGColor: UIColor?
    var normalBGColor: UIColor?

    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? selectedBGColor : normalBGColor
        }
    }
}
