//
//  NetworkClient.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

protocol NetworkClient {
    func call<T: Decodable>(urlRequest: URLRequest) async throws -> T
    func getCall<T: Decodable>(token: String, url: String, queryParams: [String : String]?) async throws -> T
    func postCall<T: Decodable>(url: String, body: Encodable?) async throws -> T
    func postImageCall<T: Decodable>(token: String, url: String, body: Encodable?) async throws -> T
    func deleteImageCall<T: Decodable>(token: String, url: String) async throws -> T
}
