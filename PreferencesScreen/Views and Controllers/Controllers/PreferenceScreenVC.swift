//
//  PreferenceScreenVC.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 23/05/21.
//

import UIKit

class PreferenceScreenVC: UIViewController {
    
    @IBOutlet weak var selectCountryView: SelectItemsView!
    @IBOutlet weak var selectTeamView: SelectItemsView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var preferencesTV: UITableView!
    
    let countriesTableView = UITableView()
    let teamsTableView = UITableView()
    var selectedView = UIView()
    
    var dataModel = PreferenceScreenDataModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCountriesList()
        self.getTeamsList()
        self.getLiveNotifPrefList()
        self.setDropDownTableViewUI(tableView: countriesTableView)
        self.setDropDownTableViewUI(tableView: teamsTableView)
        self.setNotifPrefTableViewUI()
        self.setSelectCountryViewUI()
        self.setSelectTeamViewUI()
        self.setSaveButtonUI()
    }
    
    
}

//MARK:- Tableview
extension PreferenceScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == countriesTableView) {
            return dataModel.countries.count
        } else if (tableView == teamsTableView) {
            return dataModel.teams.count
        }
        return dataModel.liveNotifPrefs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == countriesTableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewNames.DropDownTVCell, for: indexPath) as? DropDownTVCell else { return UITableViewCell() }
        
            cell.country = dataModel.countries[indexPath.row]
            
            return cell
        } else if (tableView == teamsTableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewNames.DropDownTVCell, for: indexPath) as? DropDownTVCell else { return UITableViewCell() }
        
            cell.team = dataModel.teams[indexPath.row]
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewNames.PreferencesTVCell, for: indexPath) as? PreferencesTVCell else { return UITableViewCell() }
        
            cell.liveNotifPref = dataModel.liveNotifPrefs[indexPath.row]
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == preferencesTV) {
            guard let cell = tableView.cellForRow(at: indexPath) as? PreferencesTVCell else { return }
            cell.isSelectedCell = !cell.isSelectedCell
        }
    }
}


//MARK:- UI
extension PreferenceScreenVC {
    private func setSelectCountryViewUI() {
        self.selectCountryView.title.text = "SELECT COUNTRY"
        self.selectCountryView.selectFieldLabel.text = "Select All"
        self.selectCountryView.showDropDown = { [unowned self] (isShown) in
            if isShown {
                self.addDropDownView(tableView: self.countriesTableView, frame: (self.selectCountryView.frame))
            } else {
                self.removeDropDownView(tableView: self.countriesTableView, frame: (self.selectCountryView.frame))
            }
            
        }
        
    }
    
    private func setSelectTeamViewUI() {
        self.selectTeamView.title.text = "SELECT TEAM"
        self.selectTeamView.selectFieldLabel.text = "All Team"
        self.selectTeamView.showDropDown = { [unowned self] (isShown) in
            if isShown {
                self.addDropDownView(tableView: self.teamsTableView, frame: (self.selectTeamView.frame))
            } else {
                self.removeDropDownView(tableView: self.teamsTableView, frame: (self.selectTeamView.frame))
            }
        }
    }
    
    private func setDropDownTableViewUI(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ViewNames.DropDownTVCell, bundle: nil), forCellReuseIdentifier: ViewNames.DropDownTVCell)
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setNotifPrefTableViewUI() {
        self.preferencesTV.register(UINib(nibName: ViewNames.PreferencesTVCell, bundle: nil), forCellReuseIdentifier: ViewNames.PreferencesTVCell)
        self.preferencesTV.estimatedRowHeight = self.preferencesTV.rowHeight
        self.preferencesTV.rowHeight = UITableView.automaticDimension
    }
    
    private func setSaveButtonUI() {
        self.save.layer.cornerRadius = 4
    }
    
    private func addDropDownView(tableView: UITableView,frame: CGRect) {
        tableView.frame = CGRect(x: frame.origin.x + 20, y: frame.origin.y + frame.height + 65, width: frame.width - 40, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1
//        dropDownTableView.layer.shadowColor = UIColor.black.cgColor
//        dropDownTableView.layer.shadowOpacity = 0.5
//        dropDownTableView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        dropDownTableView.layer.shadowRadius = 5
//        dropDownTableView.layer.masksToBounds = false
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            tableView.frame = CGRect(x: frame.origin.x + 20, y: frame.origin.y + frame.height + 65, width: frame.width - 40, height: 200)
        }, completion: nil)
    }
    
    private func removeDropDownView(tableView: UITableView,frame: CGRect) {
//        let frames = selectedView.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            tableView.frame = CGRect(x: frame.origin.x + 20, y: frame.origin.y + frame.height + 65, width: frame.width - 40, height: 0)
        }, completion: nil)
    }
}

