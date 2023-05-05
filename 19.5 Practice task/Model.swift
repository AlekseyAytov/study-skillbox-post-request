//
//  Model.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import UIKit

struct NetworkModel: Codable {
    let birth: Int
    let occupation: String
    let name: String
    let lastname: String
    let country: String
    
    init(data: [ModelTitle: String]) {
        self.birth  = Int(data[.birth] ?? "0")!
        self.occupation = data[.occupation] ?? ""
        self.name = data[.name] ?? ""
        self.lastname = data[.lastname] ?? ""
        self.country = data[.country] ?? ""
    }
}

enum ModelTitle: CaseIterable {
    case birth
    case occupation
    case name
    case lastname
    case country
}
