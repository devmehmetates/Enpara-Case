//
//  DataDecoder.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

import Foundation

extension Data {

    func toModel<T: Codable>() -> T? {
        try? JSONDecoder().decode(T.self, from: self)
    }
}
