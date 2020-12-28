//
//  PhotoViewController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var delegate: UICollectionViewDelegateFlowLayout!
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
                as? PhotoCell
        else { return UICollectionViewCell() }
           
        cell.photo.image = UIImage(named: "darth-vader")
        //cell.friendName.text = "\(FriendsCell.friends[indexPath.row])"
    
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.frame.width / 5
        let size = CGSize(width: width, height: width)
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionCell at \(indexPath)")
    }

}
