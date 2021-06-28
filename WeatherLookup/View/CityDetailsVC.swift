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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityDetailsVM.dataArray.count > 0 ?  cityDetailsVM.dataArray.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        if cityDetailsVM.dataArray.count > indexPath.row {
            let location = cityDetailsVM.dataArray[indexPath.row] as? WeatherObject
            cell.textLabel?.text = location?.temparature
            cell.detailTextLabel?.text = location?.humidity
        }else{
            cell.textLabel?.text = "No details are available."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
