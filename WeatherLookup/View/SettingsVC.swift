//
//  SettingsVC.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var settingsVM = SettingsVM()

    let navigatonBarTitle = "Settings"
    let resetConfirmationQuestionText = "Are you sure you want to reset all the bookmarked locations?"
    let resetConfirmationMessageText = "All the bookmarked locations have been reset!!"
    let alertTitleText = "WeatherLookup"
    let yesButtonText = "Yes"
    let noButtonText = "No"
    let okButtonText = "OK"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = navigatonBarTitle
        registerNib()
        
        tableView.tableFooterView =  UIView()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func  registerNib() {
        tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    
    @IBAction func resetAllLocationsButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: alertTitleText,
                                      message: resetConfirmationQuestionText,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: noButtonText, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: yesButtonText, style: .destructive, handler: { action in
            self.resetAllLocations()
        }))

        self.present(alert, animated: true)
    }
    
    func resetAllLocations(){
        let homeVM = HomeVM()
        homeVM.removeAllLocations {
            let alert = UIAlertController(title: self.alertTitleText,
                                          message:self.resetConfirmationMessageText,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: self.okButtonText, style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
}

extension SettingsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsVM.settingsDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        if settingsVM.settingsDataArray.count > indexPath.row {
            
            cell.locationTitleTextLabel.text = settingsVM.settingsDataArray[indexPath.row]
            cell.accessoryType = settingsVM.setAccessoryTypeForCellWithType(type: settingsVM.settingsDataArray[indexPath.row])
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        settingsVM.updateThePreference(isMetric: indexPath.row == 0 )
        tableView.reloadData()
    }
}

