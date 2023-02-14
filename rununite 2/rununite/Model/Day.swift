//
//  Day.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import Foundation
struct Day: Decodable {
    var dayName: String
    var run: Run?
    var team: String?
    var city: String?
}
