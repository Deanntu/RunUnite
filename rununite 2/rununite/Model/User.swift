//
//  User.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import Foundation
struct User: Decodable {
    var username: String
    var email: String
    var password: String?
    var team: String?
    var city: City?
}
