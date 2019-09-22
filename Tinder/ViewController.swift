//
//  ViewController.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/20/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class ViewController: UIViewController {

    let topNavigationStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let homeBottomControlsStackview = HomeBottomControlsStackview()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cardsDeckView.backgroundColor = .white
        setupLayout()
    }

    //MARK:- Fileprivate
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topNavigationStackView, cardsDeckView, homeBottomControlsStackview])
        overallStackView.axis = .vertical
        view.sv(overallStackView)
        overallStackView.Top == view.safeAreaLayoutGuide.Top
        overallStackView.fillHorizontally()
        overallStackView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
}

