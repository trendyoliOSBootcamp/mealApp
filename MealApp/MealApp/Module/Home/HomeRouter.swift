//
//  HomeRouter.swift
//  MealApp
//
//  Created by Mine on 23.05.2021.
//

import UIKit

final class HomeRouter {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    static func createModule() -> HomeViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor)
        view?.presenter = presenter
        interactor.output = presenter
        return view
    }
}
