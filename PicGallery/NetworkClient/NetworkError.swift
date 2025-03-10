//
//  NetworkError.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

enum NetworkError: Error {
    case nilResponse
    case badUrl
    case encoding
    case response(Int)
}
