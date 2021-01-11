//
//  PhotoViewController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit


class PhotoViewController: UICollectionViewController {
    
    
    var images = [UIImage?]()

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        else { return UICollectionViewCell() }
        cell.userImage.image = images[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

}
