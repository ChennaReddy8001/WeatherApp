//
//  CityDetailsVC.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class CityDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedLocation : Location?
    var cityDetailsVM : CityWeatherDetailsVM = CityWeatherDetailsVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedLocation?.title
        
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
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonAction))
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
        if cityDetailsVM.dataArray.count > 0 {
            let array = cityDetailsVM.dataArray[section] as [WeatherObject]
            return array.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoCell.identifier, for: indexPath) as? WeatherInfoCell else { return UITableViewCell() }
        
        if cityDetailsVM.dataArray.count > indexPath.section {
            let array = cityDetailsVM.dataArray[indexPath.section] as [WeatherObject]
            let weatherObject = array[indexPath.row] as WeatherObject
            cell.dateAndTimeTextLabel.text = weatherObject.dateString
            cell.configureCellWithWeathInfo(weatherObject: weatherObject)
        }else{
            cell.textLabel?.text = "No details are available."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  cityDetailsVM.dataArray.count > 0 ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if cityDetailsVM.dataArray.count > 0 {
            let array = cityDetailsVM.dataArray[section] as [WeatherObject]
            if array.count > 0 {
                let weatherObject = array[0] as WeatherObject
                return weatherObject.dateInDateFormat.asString(style: .full)
            }
        }
        return ""
    }
}
