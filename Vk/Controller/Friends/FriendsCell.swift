//
//  FriendsCell.swift
//  Vk
//
//  Created by Евгений Дербенев on 24.12.2020.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: Avatar!
    
    
    @IBAction func LogOut(_ sender: Any) {
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.friendName.text = nil
        self.friendImage.imageView.image = nil
    }
    
    func configure(with user: User) {
        self.friendName.text = "\(user.firstName) \(user.lastName)"
        let url = URL(string: user.photo100)
        self.friendImage.imageView.kf.setImage(with: url)
    }
}
