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
    
    let dropDownTableView = UITableView()
    var selectedView = UIView()
    
    var countries:[Country] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        
        self.getCountriesList()
        self.setTableViewUI()
        self.setSelectCountryViewUI()
        self.setSelectTeamViewUI()
        self.setSaveButtonUI()
    }
    
    
}

//MARK:- Tableview
extension PreferenceScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    private func registerTVCells() {
        self.dropDownTableView.register(UINib(nibName: ViewNames.DropDownTVCell, bundle: nil), forCellReuseIdentifier: ViewNames.DropDownTVCell)
        self.preferencesTV.register(UINib(nibName: ViewNames.PreferencesTVCell, bundle: nil), forCellReuseIdentifier: ViewNames.PreferencesTVCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView == dropDownTableView) ? countries.count : 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == dropDownTableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewNames.DropDownTVCell, for: indexPath) as? DropDownTVCell else { return UITableViewCell() }
        
            cell.country = countries[indexPath.row]
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewNames.PreferencesTVCell, for: indexPath) as? PreferencesTVCell else { return UITableViewCell() }
        
//            cell.country = countries[indexPath.row]
            
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
        self.selectCountryView.showDropDown = { [weak self] (isShown) in
            if isShown {
                self?.addDropDownView(frame: (self?.selectCountryView.frame)!)
            } else {
                self?.removeDropDownView(frame: (self?.selectCountryView.frame)!)
            }
            
        }
        
    }
    
    private func setSelectTeamViewUI() {
        self.selectTeamView.title.text = "SELECT TEAM"
        self.selectTeamView.selectFieldLabel.text = "All Team"
        self.selectTeamView.showDropDown = { [weak self] (isShown) in
            if isShown {
                self?.addDropDownView(frame: (self?.selectTeamView.frame)!)
            } else {
                self?.removeDropDownView(frame: (self?.selectTeamView.frame)!)
            }
        }
    }
    
    private func setTableViewUI() {
        self.registerTVCells()
        self.dropDownTableView.estimatedRowHeight = dropDownTableView.rowHeight
        self.dropDownTableView.rowHeight = UITableView.automaticDimension
        self.dropDownTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.preferencesTV.estimatedRowHeight = dropDownTableView.rowHeight
        self.preferencesTV.rowHeight = UITableView.automaticDimension
    }
    
    private func setSaveButtonUI() {
        self.save.layer.cornerRadius = 4
    }
    
    private func addDropDownView(frame: CGRect) {
        dropDownTableView.frame = CGRect(x: frame.origin.x + 20, y: frame.origin.y + frame.height + 65, width: frame.width - 40, height: 0)
        self.view.addSubview(dropDownTableView)
        dropDownTableView.layer.cornerRadius = 5
        dropDownTableView.layer.borderColor = UIColor.red.cgColor
        dropDownTableView.layer.borderWidth = 5
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.dropDownTableView.frame = CGRect(x: frame.origin.x + 20, y: frame.origin.y + frame.height + 65, width: frame.width - 40, height: 200)
        }, completion: nil)
    }
    
    private func removeDropDownView(frame: CGRect) {
//        let frames = selectedView.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.dropDownTableView.frame = CGRect(x: frame.origin.x + 20, y: frame.origin.y + frame.height + 65, width: frame.width - 40, height: 0)
        }, completion: nil)
    }
}

