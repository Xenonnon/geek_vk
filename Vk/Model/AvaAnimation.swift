//
//  AvaAnimation.swift
//  Vk
//
//  Created by Евгений Дербенев on 31.12.2020.
//

import UIKit

extension UIButton {
    func avaAnimation(avatarAnimation: UIImageView) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 350.0
        animation.duration = 0.7
        avatarAnimation.layer.add(animation, forKey: nil)
    }
}

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
