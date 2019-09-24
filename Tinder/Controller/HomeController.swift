//
//  ViewController.swift
//  Tinder
//
//  Created by Nicholas Wong on 9/20/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class HomeController: UIViewController {

    let topNavigationStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let homeBottomControlsStackview = HomeBottomControlsStackview()
    let cardViewModels: [CardViewModel] = {
        let models = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "kelly3"),
            User(name: "Jane", age: 20, profession: "Student", imageName: "jane1"),
            Advertiser(title: "Slide Out Menu Course", brandName: "Let's Build That App", posterPhotoName: "slide_out_menu_poster")] as [CardViewModelable]
        return models.map { $0.toCardViewModel() }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cardsDeckView.backgroundColor = .white
        setupLayout()
        setupDummyCards()
    }

    //MARK:- Fileprivate
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topNavigationStackView, cardsDeckView, homeBottomControlsStackview])
        overallStackView.axis = .vertical
        view.sv(overallStackView)
        overallStackView.Top == view.safeAreaLayoutGuide.Top
        overallStackView.fillHorizontally()
        overallStackView.Bottom == view.safeAreaLayoutGuide.Bottom
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.cardViewModel = cardVM
            cardsDeckView.sv(cardView)
            cardView.fillContainer()
        }
    }
}

