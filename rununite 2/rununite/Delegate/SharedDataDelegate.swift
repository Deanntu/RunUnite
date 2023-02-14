//
//  SharedDataDelegate.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import Foundation
protocol SharedDataDelegate {
    func userListLoaded()
    func teamListLoaded()
    func cityListLoaded()
}

extension SharedDataDelegate {
    func userListLoaded() {}
    func teamListLoaded() {}
    func cityListLoaded() {}
}
