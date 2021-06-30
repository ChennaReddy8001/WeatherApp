//
//  CityDetailsVC.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class CityDetailsVC: UIViewController {
    
    let placeHolderTextForNoResultsCase = "No details are available."
    let settingsButtonTitle = "Settings"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedLocation : LocationObject?
    var cityDetailsVM  = CityWeatherDetailsVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedLocation?.locationAddress
        
        tableView.tableFooterView =  UIView()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        addSettingsBarButtonItem()
        getDataForTheSelectedLocation()
        registerNib()
        
    }
    
    private func  registerNib() {
        tableView.register(UINib(nibName: WeatherInfoCell.identifier, bundle: nil), forCellReuseIdentifier: WeatherInfoCell.identifier)
    }
    
    func getDataForTheSelectedLocation(){
        activityIndicator.startAnimating()
        cityDetailsVM.getWeatherInfoForTheSelectedLocation(completionHandler: {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        })
    }
    
    func addSettingsBarButtonItem(){
        //For righter button item
        let settingsButton = UIBarButtonItem(title: settingsButtonTitle , style: .plain, target: self, action: #selector(settingsButtonAction))
        self.navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func settingsButtonAction() {
        let settingsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC")
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}



extension CityDetailsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityDetailsVM.dataArray.count > 0 ? cityDetailsVM.dataArray.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityDetailsVM.numberOfrowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoCell.identifier, for: indexPath) as? WeatherInfoCell else { return UITableViewCell() }
        
        
        if let object = cityDetailsVM.getWeatherObjectAtIndexPath(indexPath: indexPath){
            cell.configureCellWithWeathInfo(weatherObject: object)
        }else{
            cell.textLabel?.text = placeHolderTextForNoResultsCase
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cityDetailsVM.getTitleForHeaderInSection(section: section)
    }
}
