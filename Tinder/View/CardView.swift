//
//  CardView.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/22/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class CardView: UIView {

    let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly3"))
    let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    fileprivate let dismissThreshold: CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        sv(imageView, informationLabel)
        imageView.fillContainer()
        imageView.contentMode = .scaleAspectFill
        informationLabel.fillHorizontally(m: 16).bottom(16)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe))
        addGestureRecognizer(panGestureRecognizer)
    }

    @objc fileprivate func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            break
        }
    }

    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees / 180 * .pi
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle).translatedBy(x: translation.x, y: translation.y)
        transform = rotationalTransformation
    }

    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let translationDirection: CGFloat = translation.x > 0 ? 1 : -1
        let shouldDismiss = abs(translation.x) > dismissThreshold
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismiss {
                let degrees: CGFloat = translation.x / 20
                let angle = degrees / 180 * .pi
                let duration = 0.5
                let translationAnimation = CABasicAnimation(keyPath: "position.x")
                translationAnimation.toValue = 700 * translationDirection
                translationAnimation.duration = duration
                translationAnimation.fillMode = .forwards
                translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
                translationAnimation.isRemovedOnCompletion = false

                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotationAnimation.toValue = angle * CGFloat.pi / 180
                rotationAnimation.duration = duration

                CATransaction.setCompletionBlock {
                    self.removeFromSuperview()
                }

                self.layer.add(translationAnimation, forKey: "translation")
                self.layer.add(rotationAnimation, forKey: "rotation")

                CATransaction.commit()
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
