//
//  WeatherInfoCell.swift
//  WeatherLookup
//
//  Created by Chenna on 6/28/21.
//

import UIKit

class WeatherInfoCell: UITableViewCell {

    
    @IBOutlet weak var dateAndTimeTextLabel: UILabel!
    @IBOutlet weak var windInfoValueLabel: UILabel!
    @IBOutlet weak var rainChancesValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var tempValuelLabel: UILabel!
    
    static let identifier = "WeatherInfoCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithWeathInfo(weatherObject : WeatherObject) {
        tempValuelLabel.text = weatherObject.temparature
        humidityValueLabel.text = weatherObject.humidity
        rainChancesValueLabel.text = weatherObject.rainChances
        windInfoValueLabel.text = weatherObject.windInfo
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let hourString = formatter.string(from:weatherObject.dateInDateFormat)
        dateAndTimeTextLabel.text = hourString
    }
    
}
