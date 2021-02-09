//
//  PhotoViewController.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit


class PhotoViewController: UICollectionViewController {
    
    @IBAction func closeFullPhotoView(_ unwindSegue: UIStoryboardSegue) {}
  
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
                self?.userImages = photos.compactMap { $0.sizes[$0.sizes.count - 1].url }
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
        controller.albumURLs = self.userImages
        controller.index = imageIdexPath.row
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

}
