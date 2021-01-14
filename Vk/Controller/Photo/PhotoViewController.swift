//
//  PhotoViewController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit


class PhotoViewController: UICollectionViewController {
    
<<<<<<< HEAD
    var images = [UIImage?]()
    
=======
    
    var images = [UIImage?]()

>>>>>>> v8
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
<<<<<<< HEAD
    
=======

>>>>>>> v8
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

}

<<<<<<< HEAD
extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.7
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1.0
        pulse.initialVelocity = 0.9
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
=======
//extension UIButton {
//    func pulsate() {
//        let pulse = CASpringAnimation(keyPath: "transform.scale")
//        pulse.duration = 0.3
//        pulse.fromValue = 0.7
//        pulse.toValue = 1.0
//        pulse.autoreverses = true
//        pulse.repeatCount = 1.0
//        pulse.initialVelocity = 0.9
//        pulse.damping = 1.0
//        layer.add(pulse, forKey: nil)
//    }
//}
>>>>>>> v7
