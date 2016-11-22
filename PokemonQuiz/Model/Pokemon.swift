//
//  Pokemon.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/20/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import Foundation

class Pokemon {
    
    var id: Int!
    var name: String!
    var tag: String!
    var gen: Int!
    var img: String!
    var color: String!
    
    init(id: Int, name: String, tag: String, gen: Int, img: String, color: String) {
        self.id = id
        self.name = name
        self.tag = tag
        self.gen = gen
        self.img = img
        self.color = color 
    }
}
