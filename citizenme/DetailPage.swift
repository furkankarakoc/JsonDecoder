//
//  DetailPage.swift
//  citizenme
//
//  Created by Furkan Karakoc on 12.10.2021.
//

import Foundation
struct Post :Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
