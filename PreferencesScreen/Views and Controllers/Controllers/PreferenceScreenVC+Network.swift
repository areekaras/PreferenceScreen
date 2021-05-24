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
                 
                self.countries = countriesArray
                print(countries)
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
                guard let teams = teamsData.Records else { return }
                               
                print(teams)
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
                guard let liveNotifPrefs = liveNotifPrefData.Records else { return }
                               
                print(liveNotifPrefs)
            }
            catch let jsonErr {
                print("jsonErr :: \(jsonErr)")
            }
        }
    }
}
