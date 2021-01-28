//
//  PhotoViewController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit


class PhotoViewController: UICollectionViewController {
    
  
    var images = [UIImage?]()
    
    var user: User?
    var userImages = [String]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var userAvatar: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        if let userId = self.user?.id {
            networkService.getPhotos(for: userId) { [weak self] photos in
                self?.userImages = photos.compactMap { $0.sizes[0].url }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowPhoto",
            let controller = segue.destination as? FullscreenPhotoVC,
            let cell = sender as? PhotoCell,
            let imageIdexPath = self.collectionView.indexPath(for: cell)
        else { return }
        
//        controller.album = self.userImages
        controller.index = imageIdexPath.row
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.userImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        else { return UICollectionViewCell() }
        
        let img = self.userImages[indexPath.row]
        
        cell.configure(with: img)
        
        return cell
    }
    

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
//        else { return UICollectionViewCell() }
//        cell.userImage.image = images[indexPath.row]
//        return cell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
}

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
