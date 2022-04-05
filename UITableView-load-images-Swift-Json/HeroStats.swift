//
//  HeroStats.swift
//  UITableView-load-images-Swift-Json
//
//  Created by Luccas Santana Marinho on 04/04/22.
//

import Foundation

struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}
