//
//  Card.swift
//  trelloLike
//
//  Created by Marion  on 18/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import Foundation

struct Card: Codable{
    let id: String
    let idList: String
    let name: String
    let pos: Double
}
