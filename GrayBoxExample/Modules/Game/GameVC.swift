//
//  GameVC.swift
//  GrayBoxExample
//
//  Created by Dipesh on 05/07/23.
//

import UIKit

class GameVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var enteredInput: Int?
    var selectableIndex: Int?
    var numberOfItems: [Int] = []
    var selectableItemIndexes: [Int] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Custom Methods
    
    private func setupUI() {
        setupCollectionView()
        setupData()
    }
    
    private func setupData() {
        if let enteredInput = enteredInput {
            numberOfItems = Array(0..<enteredInput)
            selectableItemIndexes = numberOfItems
            reloadItems()
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ItemRowCell", bundle: nil), forCellWithReuseIdentifier: "ItemRowCell")
    }
    
    private func reloadItems() {
        guard !selectableItemIndexes.isEmpty else {
            selectableIndex = nil
            showAlert(title: "Info", message: "Game Over!!!")
            collectionView.reloadData()
            return
        }
        
        selectableIndex = selectableItemIndexes.randomElement()
        selectableItemIndexes.removeAll(where: { $0 == selectableIndex })
        collectionView.reloadData()
    }
}

extension GameVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemRowCell", for: indexPath) as? ItemRowCell else {
            return UICollectionViewCell()
        }
        
        if selectableItemIndexes.contains(indexPath.row) {
            cell.backgroundColor = .white
        } else if selectableIndex == indexPath.row {
            cell.backgroundColor = .blue
        } else {
            cell.backgroundColor = .gray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectableIndex == indexPath.row {
            reloadItems()
        }
    }
}

extension GameVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let numberOfColumns: CGFloat = 4
        let totalSpacing = (numberOfColumns - 1) * spacing
        let width = (collectionView.bounds.width - totalSpacing) / numberOfColumns
        let height = width
        return CGSize(width: width, height: height)
    }
}
