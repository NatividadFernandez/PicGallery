//
//  ComponentExtension.swift
//  PicGallery
//
//  Created by Natividad on 15/7/24.
//

import SwiftUI

extension URL {
    func queryParameters() -> [String: String] {
        var params = [String: String]()
        
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        
        if let fragment = components?.fragment {
            let fragmentItems = fragment.split(separator: "&")
            for item in fragmentItems { let pair = item.split(separator: "=")
                if pair.count == 2, let key = pair.first, let value = pair.last {
                    params[String(key)] = String(value)
                }
            }
        }
        
        return params
    }
}
