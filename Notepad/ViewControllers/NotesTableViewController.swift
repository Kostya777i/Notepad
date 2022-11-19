//
//  NotesTableViewController.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    @IBOutlet weak var addNewNote: UITabBarItem!
    
    var notes = StorageManager.shared.fetchData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTabBar()
        setupView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNote", for: indexPath)
        
        let note = notes[indexPath.row]
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = note.name
        
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        showAlert(note: note) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentNote = notes[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(currentNote)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9696926475, green: 0.997697413, blue: 0.856333971, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.9696926475, green: 0.997697413, blue: 0.856333971, alpha: 1)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.3911720514, green: 0.5607091784, blue: 0.550804317, alpha: 0.9263658588)
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
    }
    
    @objc private func addNewTask() {
        showAlert()
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.tintColor = .darkGray
        
        
    }
}

extension NotesTableViewController {
    
    func showAlert(note: Note? = nil, completion: (() -> Void)? = nil) {
        var title = "New Note"
        if note != nil { title = "Update Note" }
        
        let alert = AlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
        
        alert.actionWithNote(note: note) { newValue in
            if let note = note, let completion = completion {
                StorageManager.shared.edit(note, newNote: newValue)
                completion()
            } else {
                StorageManager.shared.saveData(newValue) { note in
                    self.notes.append(note)
                    self.tableView.insertRows(
                        at: [IndexPath(row: self.notes.count - 1, section: 0)],
                        with: .automatic)
                }
            }
        }
        
        present(alert, animated: true)
    }
}
