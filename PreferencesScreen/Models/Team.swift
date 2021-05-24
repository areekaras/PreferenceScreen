//
//  Team.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import Foundation

public struct ResponseTeamData: Codable {
    let ResponseCode:String?
    let Message:String?
    let Data: TeamsData?
}

public struct TeamsData: Codable {
    let Records:[Team]?
    let TotalRecords:String?
}

public struct Team: Codable {
    let TeamGUID:String?
    let TeamName:String?
    let AR_TeamName:String?
}
