//
//  Toy.swift
//  DonationBox
//
//  Created by Juliano Costa Silva on 03/08/22.
//

import Foundation

struct Toy: Codable {
    var id: String?
    var name: String = ""
    var status: Int = 0
    var donorName: String = ""
    var donorAddress: String = ""
    var donorPhone: String = ""
    
    var toyStatus: String {
        switch status {
        case 0:
            return "New"
        case 1:
            return "Used"
        default:
            return "Needs Repair"
        }
    }
}
