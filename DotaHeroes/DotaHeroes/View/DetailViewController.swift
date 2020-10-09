//
//  DetailViewController.swift
//  DotaHeroes
//
//  Created by Renaldy on 09/10/20.
//

import UIKit
import Nuke

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var maxAttackLabel: UILabel!
    @IBOutlet weak var moveSpeedLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    
    private var hero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func set(hero: Hero) {
        self.hero = hero
    }
    
    func setupView() {
        navigationItem.title = hero.fullName
        Nuke.loadImage(with: hero.imageUrl!, into: avatarImage)
        typeLabel.text = hero.type?.rawValue
        attributeLabel.text = hero.attribute?.rawValue
        healthLabel.text = String(hero.health)
        maxAttackLabel.text = String(hero.maxAttack)
        moveSpeedLabel.text = String(hero.speed)
        rolesLabel.text = hero.roles.joined(separator: ", ")
    }
}
