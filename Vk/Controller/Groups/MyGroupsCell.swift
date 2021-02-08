//
//  MyGroupsCell.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    @IBOutlet weak var myGroupName: UILabel!
    @IBOutlet weak var myGroupImageView: Avatar!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myGroupName.text = nil
        self.myGroupImageView.imageView.image = nil
    }
    
    func configure(with group: Group) {
        self.myGroupName.text = group.name
        let url = URL(string: group.photo100)
        self.myGroupImageView.imageView.kf.setImage(with: url)
    }
}

