//
//  ActiveAlert.swift
//  PicGallery
//
//  Created by Natividad on 15/7/24.
//

import Foundation

enum ActiveAlertLogin {
    case showAlertView
    case showAlertViewModel
}

extension ActiveAlertLogin: Identifiable {
    var id: Int {
        hashValue
    }
}

enum ActiveAlertGallery{
    case showAlertDelete
    case showAlertViewModel
}

extension ActiveAlertGallery: Identifiable {
    var id: Int {
        hashValue
    }
} 




