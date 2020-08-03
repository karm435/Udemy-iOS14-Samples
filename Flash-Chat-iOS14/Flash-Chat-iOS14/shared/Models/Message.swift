//
//  Message.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 3/8/20.
//

import Foundation

struct Message : Identifiable, Codable {
    var id: UUID
    var body: String
    var senddate: Date
}
