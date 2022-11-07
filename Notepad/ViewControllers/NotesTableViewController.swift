//
//  NotesTableViewController.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import UIKit

class NotesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTabBar()
        setupView()
        
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
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.tintColor = .darkGray
    }
    
    
}

extension NotesTableViewController {
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
}
