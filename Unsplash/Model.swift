//
//  Model.swift
//  Unsplash
//
//  Created by Иван Карамазов on 30.08.2021.
//

import Foundation


struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Results]
}


struct Results: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let small: String
}
