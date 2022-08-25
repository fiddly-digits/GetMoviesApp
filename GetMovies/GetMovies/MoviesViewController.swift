//
//  MoviesViewController.swift
//  GetMovies
//
//  Created by Roberto Cruz on 23/08/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        
        
        // MARK: - Xib Registration
        var cellNib = UINib(nibName: "MoviesCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "MoviesCell")
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        return cell
        
    }
    
    
}
