//
//  MoviesViewController.swift
//  GetMovies
//
//  Created by Roberto Cruz on 23/08/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // TODO: - Create perform segue in order to launch flag to Search View Controller
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        
        
        // MARK: - Xib Registration
        var cellNib = UINib(nibName: "MoviesCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "MoviesCell")
    }

    
    @IBAction func SearchButtonPressed(_ sender: UIBarButtonItem) {

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

extension MoviesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSearch" {
            let searchIdentifier = "movie"
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.searchIdentifier = searchIdentifier
            print(searchIdentifier)
        }
    }
}
