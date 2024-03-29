//
//  User.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/23/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import Foundation
import UIKit

struct User: CardViewModelable {
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]

    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
    }
}
