//
//  NewsCell.swift
//  Vk
//
//  Created by Евгений Дербенев on 28.12.2020.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsAvatar: UIImageView!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLikeCounter: UILabel!
    @IBOutlet weak var newsLikeButton: UIButton!
    @IBOutlet weak var newsViewsCounter: UILabel!
    @IBOutlet weak var newsViewsSignBtn: UIButton!
    @IBAction func pulseButton(_ sender: UIButton) {
        sender.pulsate()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsLikeButton.setImage(#imageLiteral(resourceName: "bluelike"), for: .selected)
        newsLikeButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        newsLikeCounter.textColor = newsLikeButton.isSelected ? .red : .systemBlue
        newsLikeCounter.text = "0"
    }
    
    @IBAction func like() {
        newsLikeButton.isSelected.toggle()
        newsLikeCounter.textColor = newsLikeButton.isSelected ? .red : .systemBlue
        newsLikeCounter.text = newsLikeButton.isSelected ? "1" : "0"
    }
}

