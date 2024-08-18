//
//  FileManager+Extension.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import Foundation

extension FileManager {
    
    static func modelFromJSON<T: Decodable>(filename: String) -> T? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { return nil }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
//            print(String(data: data, encoding: .utf8)!)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
