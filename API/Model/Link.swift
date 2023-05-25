//
//  Link.swift
//  API
//
//  Created by Vijendra Vaishya on 12/04/24.
//
//
//import Foundation

struct Analytics: Codable {
    let totalClicks: Int
    let location: String
    let source: String
}

struct UserData: Decodable {
    let name: String
}
