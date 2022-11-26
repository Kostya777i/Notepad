//
//  NoteViewController.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    var note: Note!
    
    var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        text()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        fetchText()
    }
    
    private func text() {
        guard let text = note.name  else { return }
        textView.text = text
    }
    
    private func fetchText() {
        guard let text = textView.text else { return }
        StorageManager.shared.edit(note, newNote: text)
    }
    
    private func setupConstraints() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
