//
//  Planets.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 15.07.2022.
//

import Foundation

struct Planets: Decodable {
    
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, rotation_period, orbital_period, diameter, climate, gravity, terrain, surface_water, population, residents, films, created, edited, url
    }
}
