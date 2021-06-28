//
//  CityDetailsVC.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class CityDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "City Details"
        
        //For righter button item
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonAction))
        self.navigationItem.rightBarButtonItem = settingsButton

    }
    
    @objc func settingsButtonAction() {
        let settingsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC")
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

