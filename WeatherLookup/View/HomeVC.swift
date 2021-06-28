//
//  ViewController.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
    }
    
    @IBAction func helpButtonAction(_ sender: Any) {
        
        let helpVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HelpVC")
        navigationController?.pushViewController(helpVC, animated: true)
    }
    
    @IBAction func addNewLocatonAction(_ sender: Any) {
        
        let addLocationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocationVC")
        navigationController?.pushViewController(addLocationVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(DataModel.shared.selctedLocations)
        tableView.reloadData()
    }
}


extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.selctedLocations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
         
        let location = DataModel.shared.selctedLocations[indexPath.row]
        cell.textLabel?.text = location.address

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailsVC")
        navigationController?.pushViewController(cityDetailsVC, animated: true)
    }
}
