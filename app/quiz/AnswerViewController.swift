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
    private let sharpButton: SelectableBGButton = SelectableBGButton()
    private let flatButton: SelectableBGButton = SelectableBGButton()
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

        configure(button: flatButton)
        flatButton.setTitle(Note.Accidental.flat.rawValue, for: .normal)
        view.addSubview(flatButton)

        for (i, note) in "ABCDEFG".map(String.init).enumerated() {
            notes.insertSegment(withTitle: note, at: i, animated: false)
        }
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.tintColor = UIColor(named: "pink")
        notes.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 48)], for: .normal)
        notes.addTarget(self, action: #selector(updateAnswer), for: .valueChanged)
        view.addSubview(notes)

        configure(button: sharpButton)
        sharpButton.setTitle(Note.Accidental.sharp.rawValue, for: .normal)
        view.addSubview(sharpButton)

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

            flatButton.topAnchor.constraint(equalTo: notes.topAnchor),
            flatButton.bottomAnchor.constraint(equalTo: notes.bottomAnchor),
            flatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            notes.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 32),
            notes.leadingAnchor.constraint(equalTo: flatButton.trailingAnchor, constant: 4),
            notes.trailingAnchor.constraint(equalTo: sharpButton.leadingAnchor, constant: -4),
            notes.heightAnchor.constraint(equalToConstant: 56),

            sharpButton.topAnchor.constraint(equalTo: notes.topAnchor),
            sharpButton.bottomAnchor.constraint(equalTo: notes.bottomAnchor),
            sharpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

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

    @objc private func accidentalButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            let button = sender == sharpButton ? flatButton : sharpButton
            button.isSelected = false
        }
        updateAnswer()
    }

    @objc private func updateAnswer() {
        guard notes.selectedSegmentIndex != UISegmentedControl.noSegment,
            let root = notes.titleForSegment(at: notes.selectedSegmentIndex)
            else {
                selectedNote = nil
                return
        }

        var noteString = root
        if flatButton.isSelected, let accidental = flatButton.titleLabel?.text {
            noteString.append(accidental)
        } else if sharpButton.isSelected, let accidental = sharpButton.titleLabel?.text {
            noteString.append(accidental)
        }
        selectedNote = Note(string: noteString)
    }

    private func updateForSelectedNote() {
        answerLabel.text = selectedNote?.name ?? "?"
        if selectedNote == nil {
            notes.selectedSegmentIndex = UISegmentedControl.noSegment
            sharpButton.isSelected = false
            flatButton.isSelected = false
        }
        submitButton.isEnabled = selectedNote != nil
    }

    private func configure(button: SelectableBGButton) {
        button.addTarget(self, action: #selector(accidentalButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "pink")
        button.setTitleColor(UIColor(named: "pink"), for: .normal)
        button.setTitleColor(UIColor(named: "yellow"), for: .selected)
        button.selectedBGColor = UIColor(named: "pink")
        button.normalBGColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
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
