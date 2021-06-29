//
//  ViewController.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var homeVM = HomeVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        tableView.tableFooterView =  UIView()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        homeVM.getAllLocations()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData), name: NSNotification.Name(rawValue: "LocationAdded"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
     @objc func refreshData(){
        DispatchQueue.main.async {
            self.homeVM.getAllLocations()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func helpButtonAction(_ sender: Any) {
        
        let helpVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HelpVC")
        navigationController?.pushViewController(helpVC, animated: true)
    }
    
    @IBAction func addNewLocatonAction(_ sender: Any) {
        
        let addLocationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocationVC")
        navigationController?.pushViewController(addLocationVC, animated: true)
    }
    
}


extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return homeVM.selctedLocations.count > 0 ? true : false
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = homeVM.selctedLocations[indexPath.row]
            homeVM.removeLocationFromCoreData(location: location)
             homeVM.selctedLocations.remove(at: indexPath.row)
            if homeVM.selctedLocations.count > 0 {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }else{
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.selctedLocations.count > 0 ? homeVM.selctedLocations.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        if homeVM.selctedLocations.count > indexPath.row {
            let location = homeVM.selctedLocations[indexPath.row]
            cell.textLabel?.text = location.locationAddress
        }else{
            cell.textLabel?.text = "Please add location by clicking on + symbol"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if homeVM.selctedLocations.count > indexPath.row {
            let cityDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailsVC") as? CityDetailsVC
            let location =  homeVM.selctedLocations[indexPath.row]
            cityDetailsVC?.selectedLocation = location
            cityDetailsVC?.cityDetailsVM = CityWeatherDetailsVM.init(with: location)
            navigationController?.pushViewController(cityDetailsVC ?? CityDetailsVC(), animated: true)
        }
    }
}
