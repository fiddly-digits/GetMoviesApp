//
//  SeriesCell.swift
//  GetMovies
//
//  Created by Roberto Cruz on 23/08/22.
//

import UIKit
import Kingfisher

class SeriesCell: UITableViewCell {

    @IBOutlet weak var seriesTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var seriesImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithValuesOf(_ series: SeriesResult) {
        print("Los generos Son: \(series.genreIDS.count)")
        
        updateUI(title: series.originalName, launchDate: series.firstAirDate, poster: series.posterPath)
    }
    
    private func updateUI(title: String?, launchDate: String?, poster: String?) {
        self.seriesTitleLabel.text = title
        self.dateTitleLabel.text = fixedDateFormatter(launchDate)
        
        guard let poster = poster else { return }
        let UrlString = "https://image.tmdb.org/t/p/w500\(poster)"
        
        guard let imageUrl = URL(string: UrlString) else { return }
        seriesImageView.kf.setImage(with: imageUrl)
        seriesImageView.layer.cornerRadius = seriesImageView.frame.size.width / 9
    }
    
}
