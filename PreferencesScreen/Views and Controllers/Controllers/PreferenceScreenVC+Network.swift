//
//  PreferenceScreenVC+Network.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import Foundation

//MARK:- Network Call
extension PreferenceScreenVC {
    func getCountriesList() {
        let network = Network()
        network.getCountries() { [unowned self]  (data, action, serviceStatus) in

            if serviceStatus == ServiceStatus.FAILED.rawValue {
                print("Error-GetCountry status failed")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(ResponseCountryData.self, from: data)

                guard let countriesData = response.Data else { return }
                guard let countriesArray = countriesData.Records else { return }
                 
                self.dataModel.countries = countriesArray
                self.dataModel.countriesF = countriesArray
                
                DispatchQueue.main.async {
                    self.countriesTableView.reloadData()
                }
            }
            catch let jsonErr {
                print("jsonErr :: \(jsonErr)")
            }
        }
    }
    
    func getTeamsList() {
        let network = Network()
        network.getTeams(countryID: 116) { [unowned self]  (data, action, serviceStatus) in
            
            if serviceStatus == ServiceStatus.FAILED.rawValue {
                print("Error-GetTeams status failed")
                return
            }
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(ResponseTeamData.self, from: data)
   
                guard let teamsData = response.Data else { return }
                guard let teamsArray = teamsData.Records else { return }
                               
                print("teamsCount \(teamsArray.count)")
                self.dataModel.teams = teamsArray
                self.dataModel.teamsF = teamsArray
                DispatchQueue.main.async {
                    self.teamsTableView.reloadData()
                }
            }
            catch let jsonErr {
                print("jsonErr :: \(jsonErr)")
            }
        }
    }
    
    func getLiveNotifPrefList() {
        let network = Network()
        network.getLiveNotifPref(countryID: 116, teamID: "7a966922-735b-ee85-d18a-95b27ba6f587") { [unowned self]  (data, action, serviceStatus) in
            
            if serviceStatus == ServiceStatus.FAILED.rawValue {
                print("Error-GetTeams status failed")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(ResponseLiveNotifPrefData.self, from: data)
                
                guard let liveNotifPrefData = response.Data else { return }
                guard let liveNotifPrefsArray = liveNotifPrefData.Records else { return }
                             
                print("livNotifPrefCount \(liveNotifPrefsArray.count)")
                self.dataModel.liveNotifPrefs = liveNotifPrefsArray
                DispatchQueue.main.async {
                    self.preferencesTV.reloadData()
                }
            }
            catch let jsonErr {
                print("jsonErr :: \(jsonErr)")
            }
        }
    }
}
