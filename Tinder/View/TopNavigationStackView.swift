//
//  TopNavigationStackView.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/20/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    let settingsButton = UIButton(type: .system)
    let messagesButton = UIButton(type: .system)
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.height(80)
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messagesButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        fireImageView.contentMode = .scaleAspectFit
        let subviews = [settingsButton, UIView(), fireImageView, UIView(), messagesButton]
        subviews.forEach { (view) in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
    }

    required init(coder: NSCoder) {
        fatalError()
    }
}
