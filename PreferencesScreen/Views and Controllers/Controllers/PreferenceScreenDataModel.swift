//
//  PreferenceScreenDataModel.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import Foundation

struct PreferenceScreenDataModel {
    var countries: [Country] = []
    var selectedCountry:Country?
    var teams: [Team] = []
    var selectedTeam:Team?
    var liveNotifPrefs: [LiveNotifPref] = []
    var selectedLiveNotifPref:[String] = []
}
