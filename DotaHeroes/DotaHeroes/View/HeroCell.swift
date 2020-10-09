//
//  HeroCell.swift
//  DotaHeroes
//
//  Created by Renaldy on 07/10/20.
//

import UIKit
import Nuke

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    
    func set(hero: Hero) {
        Nuke.loadImage(with: hero.imageUrl!, into: heroImage)
        heroLabel.text = hero.fullName
    }
}
