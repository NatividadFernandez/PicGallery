//
//  TokenRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

protocol TokenRemoteService {
    func authorize() async throws -> URL
}
