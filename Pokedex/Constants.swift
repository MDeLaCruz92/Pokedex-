//
//  Constants.swift
//  Pokedex
//
//  Created by Michael De La Cruz on 11/14/16.
//  Copyright © 2016 Michael De La Cruz. All rights reserved.
//

import Foundation

let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

// used closure to have a way to let the view controller know when that data will be available.
typealias DownloadComplete = () -> ()
