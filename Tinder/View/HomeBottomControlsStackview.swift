//
//  HomeBottomControlsStackview.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/22/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class HomeBottomControlsStackview: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.height(120)
        let subviews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        subviews.forEach { (view) in
            addArrangedSubview(view)
        }
        distribution = .fillEqually
    }

    required init(coder: NSCoder) {
        fatalError()
    }
}
