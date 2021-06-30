//
//  HomeTableViewCell.swift
//  WeatherLookup
//
//  Created by Chenna on 6/30/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var locationTitleTextLabel: UILabel!

    static let identifier = "HomeTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithLocationInfo(locationObject : LocationObject) {
        locationTitleTextLabel.text = locationObject.locationAddress ?? ""
    }
    
}
