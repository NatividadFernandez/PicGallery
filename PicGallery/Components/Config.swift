//
//  Config.swift
//  PicGallery
//
//  Created by Natividad on 15/7/24.
//

import Foundation

class Config {
    static let shared = Config()
    
    private init() {}
    
    func value(forKey key: String) -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let config = try? PropertyListDecoder().decode([String: String].self, from: xml) else {
            return nil
        }
        return config[key]
    }
}
