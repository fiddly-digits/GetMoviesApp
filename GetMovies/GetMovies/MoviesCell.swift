//
//  MoviesCell.swift
//  GetMovies
//
//  Created by Roberto Cruz on 24/08/22.
//

import UIKit
import Kingfisher

class MoviesCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithValuesOf(_ movie: MovieResult) {
        updateUI(title: movie.originalTitle, launchDate: movie.releaseDate, poster: movie.posterPath)
    }
    
    private func updateUI(title: String?, launchDate: String?, poster: String?) {
        self.movieTitleLabel.text = title
        self.launchDateLabel.text = fixedDateFormatter(launchDate)
        
        guard let poster = poster else { return }
        let UrlString = "https://image.tmdb.org/t/p/w500\(poster)"
        
        guard let imageUrl = URL(string: UrlString) else { return }
        movieImageView.kf.setImage(with: imageUrl)
        movieImageView.layer.cornerRadius = movieImageView.frame.size.width / 9
    }
    
}

func fixedDateFormatter(_ date: String?) -> String {
    var fixDate: String = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyy-MM-dd"
    if let originalDate = date {
        if let newDate = dateFormatter.date(from: originalDate) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            fixDate = dateFormatter.string(from: newDate)
        }
    }
    return fixDate
}
