//
//  Team.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import Foundation
import Foundation
struct Team: Decodable {
    var teamName: String
    var weekly: [Day]?
    var city: City?
}
