//
//  SeSacMovieTableViewCell.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/20.
//

import UIKit

class SeSacMovieTableViewCell: UITableViewCell {

    // MARK: - outlet
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    
    func configureCell(data: Movie) {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = data.title
        releaseLabel.text = "\(data.releaseDate) | \(data.runtime)분 \(data.rate)점"
        overviewLabel.text = data.overview
        overviewLabel.numberOfLines = 3
    }
}
