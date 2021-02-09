//
//  UIImageView+Ext.swift
//  Vk
//
//  Created by Евгений Дербенев on 2/9/21.
//

import UIKit

extension UIImageView {
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
    }
}
