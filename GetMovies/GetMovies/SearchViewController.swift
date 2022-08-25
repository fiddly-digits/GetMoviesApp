//
//  SearchViewController.swift
//  GetMovies
//
//  Created by Roberto Cruz on 24/08/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let search = Search()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.resignFirstResponder()
        
        //MARK: - Xib Registration
        var cellNib = UINib(nibName: "MoviesCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "MoviesCell")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    func performSearch() {
        search.performSearch(for: searchBar.text!, page: 1) { success in
            if !success {
                let alert = UIAlertController(title: "Error", message: NSLocalizedString("There was an error accessing the iTunes Store. Please try again", comment: "Error alert: message"), preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            self.tableView.reloadData()
        }
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch search.state {
        case .notSearchedYet:
            return 0
        case .loading:
            print("Loading ")
            return 1
        case .noResults:
            print("No results")
            return 1
        case .results(let list):
            return list.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            // Should never get here
            fatalError("\(Error.self)")
            
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            return cell
            
        case .noResults:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            return cell
            
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            let searchResult = list[indexPath.row]
            cell.setCellWithValuesOf(searchResult)
            return cell
        }
    }
}
