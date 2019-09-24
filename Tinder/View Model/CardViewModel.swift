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

struct CardViewModel {
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}
