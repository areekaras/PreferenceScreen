//
//  LiveNotifPref.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import Foundation

public struct ResponseLiveNotifPrefData: Codable {
    let ResponseCode:String?
    let Message:String?
    let Data: LiveNotifPrefData?
}

public struct LiveNotifPrefData: Codable {
    let Records:[LiveNotifPref]?
    let TotalRecords:String?
}

public struct LiveNotifPref: Codable {
    let NotificationTypeID:String?
    let NotificationType:String?
    let AR_NotificationType:String?
}
