//
//  NetworkConstants.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

struct NetworkConstants {
    
    static func requestPathWithEndpoint(_ endpoint: String, page: Int? = nil) -> String {
        if let page = page {
            return "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=11459cff1c1ce00e3202addab99f3a91&language=en-us&page=\(page)"
        }
        
        return "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=11459cff1c1ce00e3202addab99f3a91&language=en-us"
    }
}
