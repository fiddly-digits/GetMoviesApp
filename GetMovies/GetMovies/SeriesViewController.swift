//
//  SeriesViewController.swift
//  GetMovies
//
//  Created by Roberto Cruz on 23/08/22.
//

import UIKit

protocol searchDataDelegate {
    func sendFlagToSearchViewController(data: String)
}

class SeriesViewController: UIViewController {
    
    // TODO: - Create perform segue in order to launch flag to Search View Controller
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        
        // MARK: - Xib Registration
        var cellNib = UINib(nibName: "SeriesCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SeriesCell")
    }
    

}


extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesCell", for: indexPath) as! SeriesCell
        return cell
        
    }
}

extension SeriesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seriesSearch" {
            let searchIdentifier = "tv"
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.searchIdentifier = searchIdentifier
            print(searchIdentifier)
        }
    }
}
