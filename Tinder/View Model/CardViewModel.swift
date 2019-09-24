//
//  CardViewModel.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/23/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

protocol CardViewModelable {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment

    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }

    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image)
        }
    }

    var imageIndexObserver: ((Int, UIImage?) -> ())?

    func advanceToNextPhoto() {
        imageIndex = min(imageNames.count - 1, imageIndex + 1)
    }

    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
