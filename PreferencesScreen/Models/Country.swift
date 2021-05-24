//
//  Country.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import Foundation

public struct ResponseCountryData: Codable {
    let ResponseCode:String?
    let Message:String?
    let Data: CountriesData?
}

public struct CountriesData: Codable {
    let Records:[Country]?
    let TotalRecords:String?
}

public struct Country: Codable {
    let CountryID:String?
    let CountryName:String?
    let AR_ContryName:String?
    let CountryLogo:String?
}
