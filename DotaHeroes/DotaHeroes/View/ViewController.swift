//
//  ViewController.swift
//  DotaHeroes
//
//  Created by Renaldy on 07/10/20.
//

import Foundation
import Combine
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heroCollectionView: UICollectionView!
    @IBOutlet weak var rolesContainer: UIView!
    
    private let viewModel = ViewModel.create()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        setupViewModel()
        navigationItem.title = "Dota Heroes"
    }
    
    private func setupViewModel() {
        viewModel.$heroes.receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.heroCollectionView.reloadData() }
            .store(in: &cancellables)
        
        viewModel.$roles.receive(on: RunLoop.main)
            .sink { [weak self] roles in self?.setupRoleSegmentedControl(roles: Array(roles).sorted()) }
            .store(in: &cancellables)
    }
    
    private func setupRoleSegmentedControl(roles: [String]) {
        let segmentedControl = UISegmentedControl(items: roles)
        segmentedControl.frame = CGRect(origin: rolesContainer.bounds.origin, size: rolesContainer.bounds.size)
        segmentedControl.addTarget(self, action: #selector(onSelect(segmentedControl:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        rolesContainer.addSubview(segmentedControl)
    }
    
    @objc func onSelect(segmentedControl: UISegmentedControl) {
        let index = segmentedControl.selectedSegmentIndex
        viewModel.filter(role: segmentedControl.titleForSegment(at: index))
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCell
        cell?.set(hero: viewModel.heroes[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController")
         as! DetailViewController
        detailViewController.set(hero: viewModel.heroes[indexPath.item])
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 5) - 8
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
