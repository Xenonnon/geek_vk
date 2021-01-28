//
//  PictSettings.swift
//  Vk
//
//  Created by Евгений Дербенев on 28.12.2020.
//

import UIKit
import Kingfisher

@IBDesignable class Avatar: UIView {
    
    var imageURL: String?
    
    @IBInspectable var shadowRadius: CGFloat = 10.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowOpacityPercent: CGFloat = 100 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let imageURL = self.imageURL else { return }
        
        let imageView = self.getImageView(rect, imageURL)
        self.addSubview(imageView)
        
        let shadowedView = self.getShadowedView(rect)
        self.insertSubview(shadowedView, belowSubview: imageView)
    }
    
    private func getImageView(_ rect: CGRect, _ imageURL: String) -> UIImageView {
        let imageView = UIImageView(frame: rect)
//        imageView.image = image
        let url = URL(string: imageURL)!
        imageView.kf.setImage(with: url)
        imageView.makeCircle()
        return imageView
    }
    
    private func getShadowedView(_ rect: CGRect) -> UIView {
        let shadowView = UIView()
        let shadowLayer = CAShapeLayer()
        shadowLayer.fillColor = UIColor.black.cgColor
        shadowLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = self.shadowColor.cgColor
        shadowLayer.shadowOffset = self.shadowOffset
        shadowLayer.shadowOpacity = Float(self.shadowOpacityPercent / 100)
        shadowLayer.shadowRadius = self.shadowRadius
        shadowView.layer.insertSublayer(shadowLayer, at: 0)
        return shadowView
    }
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}

extension UIImageView {

    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
    }
}


class ImageModOne: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}

class ImageModTwo: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 6.0
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = false
    }
    
}
