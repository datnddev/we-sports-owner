//
//  ListBillReponse.swift
//  WeSports
//
//  Created by datNguyem on 08/12/2021.
//

import Foundation

struct ListBillResponse: Codable {
    var message: String
    var status: Int
    var data: [Bill]?
}
