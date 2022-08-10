//
//  Movies.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

struct Movies: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
