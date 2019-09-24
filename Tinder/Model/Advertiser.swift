//
//  Advertiser.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/23/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

struct Advertiser {
    let title: String
    let brandName: String
    let posterPhotoName: String

    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 30, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: "\n\(brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        return CardViewModel(imageName: posterPhotoName, attributedString: attributedText, textAlignment: .center)
    }
}
