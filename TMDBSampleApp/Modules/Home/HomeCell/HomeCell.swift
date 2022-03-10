//
//  HomeCell.swift
//  TMDBSampleApp
//
//  Created by appcent on 10.03.2022.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(movie: MovieResult) {
        pointLbl.text = "\(movie.voteCount ?? 0)"
        nameLbl.text = "\(movie.title ?? "")"
    }
}
