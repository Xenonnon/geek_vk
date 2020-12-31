//
//  PhotoCell.swift
//  Vk
//
//  Created by Евгений Дербенев on 13.12.2020.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBAction func pulseButton(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(#imageLiteral(resourceName: "bluelike"), for: .selected)
        likeButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        likeCounter.textColor = likeButton.isSelected ? .red : .systemBlue
    }
    
    @IBAction func like() {
        likeButton.isSelected.toggle()
        likeCounter.textColor = likeButton.isSelected ? .red : .systemBlue
        likeCounter.text = likeButton.isSelected ? "1" : "0"
    }
    
}
