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

    var cardViewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: cardViewModel.imageNames[0])
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barStackView.addArrangedSubview(barView)
            }
            barStackView.arrangedSubviews.first?.backgroundColor = .white
            setupImageIndexObserver()
        }
    }

    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (imageIndex, image) in
            self.barStackView.arrangedSubviews.forEach({ $0.backgroundColor = self.barDeselectedColor })
            self.barStackView.arrangedSubviews[imageIndex].backgroundColor = .white
            self.imageView.image = image
        }
    }

    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly3"))
    fileprivate let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    fileprivate let barStackView = UIStackView()

    fileprivate let dismissThreshold: CGFloat = 80
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe))
        addGestureRecognizer(panGestureRecognizer)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        sv(imageView)
        imageView.fillContainer()
        imageView.contentMode = .scaleAspectFill
        setupBarStackView()
        setupGradientLayer()
        sv(informationLabel)
        informationLabel.fillHorizontally(m: 16).bottom(16)
    }

    let gradientLayer = CAGradientLayer()

    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }

    fileprivate func setupBarStackView() {
        sv(barStackView)
        barStackView.fillHorizontally(m: 8).top(8).height(4)
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    }

    @objc fileprivate func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
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
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle).translatedBy(x: translation.x / 2, y: translation.y / 2)
        transform = rotationalTransformation
    }

    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let translationDirection: CGFloat = translation.x > 0 ? 1 : -1
        let shouldDismiss = abs(translation.x) > dismissThreshold
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismiss {
                let angle: CGFloat = 15
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

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
