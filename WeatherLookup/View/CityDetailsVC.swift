//
//  CityDetailsVC.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class CityDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
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
        
    }
    
    func getDataForTheSelectedLocation(){
        cityDetailsVM.getWeatherInfoForTheSelectedLocation(completionHandler: {
            DispatchQueue.main.async {
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
        
        let  cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        if cityDetailsVM.dataArray.count > indexPath.section {
            let array = cityDetailsVM.dataArray[indexPath.section] as [WeatherObject]
            let weatherObject = array[indexPath.row] as WeatherObject
            cell.textLabel?.text = weatherObject.temparature
            cell.detailTextLabel?.text = weatherObject.humidity
            print(weatherObject.dateString)
            print(weatherObject.dateInDateFormat)
        }else{
            cell.textLabel?.text = "No details are available."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
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
