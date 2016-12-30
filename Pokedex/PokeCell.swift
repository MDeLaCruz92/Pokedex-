//
//  PokeCell.swift
//  Pokedex
//
//  Created by Michael De La Cruz on 11/12/16.
//  Copyright © 2016 Michael De La Cruz. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
  
  @IBOutlet weak var thumbImg: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var pokemon: Pokemon!
  
  // Changed images to rounded corners
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layer.cornerRadius = 5.0
  }
  
  func configureCell(_ pokemon: Pokemon) {
    self.pokemon = pokemon
    nameLabel.text = self.pokemon.name.capitalized
    thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
  }
}
