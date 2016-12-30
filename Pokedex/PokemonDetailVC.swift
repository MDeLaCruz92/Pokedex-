//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Michael De La Cruz on 11/13/16.
//  Copyright © 2016 Michael De La Cruz. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
  
  var pokemon: Pokemon!
  
  @IBOutlet weak var mainImg: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var defenseLabel: UILabel!
  @IBOutlet weak var baseAttackLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var pokedexIDLabel: UILabel!
  @IBOutlet weak var currentEvoImage: UIImageView!
  @IBOutlet weak var nextEvoImage: UIImageView!
  @IBOutlet weak var evoLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // if the passing of the data work correctly
    nameLabel.text = pokemon.name.capitalized
    
    // Allows to transfer API data image to
    let img = UIImage(named: "\(pokemon.pokedexId)")
    mainImg.image = img
    currentEvoImage.image = img
    pokedexIDLabel.text = "\(pokemon.pokedexId)"
    pokemon.downloadPokemonDetail {
      // Whatever we write will only be called after the network call is complete!
      self.updateUI()
    }
  }
  
  func updateUI() {
    baseAttackLabel.text = pokemon.attack
    defenseLabel.text = pokemon.defense
    heightLabel.text = pokemon.height
    weightLabel.text = pokemon.weight
    typeLabel.text = pokemon.type
    descriptionLabel.text = pokemon.description
    
    if pokemon.nextEvoId == "" {
      evoLabel.text = "No Evolutions"
      nextEvoImage.isHidden = true
    } else {
      nextEvoImage.isHidden = false
      nextEvoImage.image = UIImage(named: pokemon.nextEvoId)
      let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
      evoLabel.text = str
    }
  }
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
