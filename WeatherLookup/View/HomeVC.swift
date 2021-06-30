//
//  ViewController.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class HomeVC: UIViewController {
    
    let emptyLocationText = "Please add location by clicking on + symbol"
    @IBOutlet weak var tableView: UITableView!
    
    var homeVM = HomeVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        setPropertiesForTableView()
        fetchData()
        addNotificationForRefreshingLocationsInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func setPropertiesForTableView() {
        
        tableView.tableFooterView =  UIView()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func addNotificationForRefreshingLocationsInfo() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchData), name: NSNotification.Name(rawValue: "LocationAdded"), object: nil)
    }
    
    @objc func fetchData(){
        self.homeVM.getAllLocations {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        return homeVM.selectedLocations.count > 0 ? true : false
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            homeVM.removeLocationAtIndex(at: indexPath) {
                if homeVM.selectedLocations.count > 0 {
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }else{
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.selectedLocations.count > 0 ? homeVM.selectedLocations.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        if homeVM.selectedLocations.count > indexPath.row {
            let location = homeVM.selectedLocations[indexPath.row]
            cell.textLabel?.text = location.locationAddress
        }else{
            cell.textLabel?.text = emptyLocationText
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if homeVM.selectedLocations.count > indexPath.row {
            let cityDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailsVC") as? CityDetailsVC
            let location =  homeVM.selectedLocations[indexPath.row]
            cityDetailsVC?.selectedLocation = location
            cityDetailsVC?.cityDetailsVM = CityWeatherDetailsVM.init(with: location)
            navigationController?.pushViewController(cityDetailsVC ?? CityDetailsVC(), animated: true)
        }
    }
}
