//
//  MoviesCell.swift
//  GetMovies
//
//  Created by Roberto Cruz on 24/08/22.
//

import UIKit

class MoviesCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithValuesOf(_ movie: MovieResult) {
        updateUI(title: movie.originalTitle, launchDate: movie.releaseDate)
    }
    
    private func updateUI(title: String?, launchDate: String?) {
        self.movieTitleLabel.text = title
        self.launchDateLabel.text = launchDate
    }
    
}
