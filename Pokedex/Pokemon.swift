//
//  Pokemon.swift
//  Pokedex
//
//  Created by Michael De La Cruz on 11/12/16.
//  Copyright © 2016 Michael De La Cruz. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvoText: String!
    fileprivate var _nextEvoName: String!
    fileprivate var _nextEvoId: String!
    fileprivate var _nextEvoLevel: String!
    fileprivate var _pokemonURL: String!
    
    var nextEvoLevel: String {
        
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var nextEvoId: String {
        
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
        var nextEvoName: String {
            
            if _nextEvoName == nil {
                _nextEvoName = ""
            }
            return _nextEvoName
        }
        var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
    }
 
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoText: String {
        
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        // Doing a network request using Alamofire and getting a response back.
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    // if there is only one type then we will get it from this if loop
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    // if there is more than one type then we loop through the rest of the types
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                } else {
                    self._type = ""
                }
                
                if let descriptArray = dict["descriptions"] as? [Dictionary<String, String>] , descriptArray.count > 0 {
                    
                    if let url = descriptArray[0]["resource_uri"] {
                        let descriptURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descriptURL).responseJSON(completionHandler: { (response) in
                            if let descriptDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descriptDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextEvoId
                                
                                if let levelExist = evolutions[0]["level"] {
                                    
                                    if let level = levelExist as? Int {
                                        self._nextEvoLevel = "\(level)"
                                    }
                                } else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                    print(self.nextEvoLevel)
                    print(self.nextEvoName)
                    print(self.nextEvoId)
                }
            }
            completed()
        }
    }
}
