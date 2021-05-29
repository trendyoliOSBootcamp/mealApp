//
//  ViewController.swift
//  MealApp
//
//  Created by Anıl Taşkıran on 22.05.2021.
//

import UIKit

// HomePresenter -> HomeViewInterface
protocol HomeViewInterface: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func endRefreshing()
    func prepareCollectionView()
    func addRefreshControl()
    func setTitle(_ title: String)
    func prepareSearchController()
    func prepareNavigationBarUI()
}

class HomeViewController: UIViewController, LoadingShowable {
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!
    
    var searchController: UISearchController?

    var presenter: HomePresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @objc
    private func pullToRefresh() {
        presenter.pullToRefresh()
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        if let restaurant = presenter.restaurant(indexPath.item) {
            cell.presenter = RestaurantCollectionCellPresenter(view: cell,
                                                               restaurant: restaurant,
                                                               delegate: self)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.calculateCellSize(collectionViewWidth: Double(collectionView.frame.size.width))
             return .init(width: size.width, height: size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: CGFloat(presenter.cellPadding), left: CGFloat(presenter.cellPadding), bottom: .zero, right: CGFloat(presenter.cellPadding))
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplay(indexPath.item)
    }
}

//MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
    func prepareNavigationBarUI() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func prepareSearchController() {
        let searchSuggestionViewController = SearchSuggestionRouter.createModule(delegate: self)
        let searchController = UISearchController(searchResultsController: searchSuggestionViewController)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchResultsUpdater = searchSuggestionViewController
        
        searchController.searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchController.searchBar.setPositionAdjustment(.init(horizontal: 5, vertical: 0), for: .search)
        
        searchController.searchBar.searchTextPositionAdjustment = .init(horizontal: 5, vertical: 0)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Vazgeç"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.primaryColor
        
        navigationItem.searchController = searchController
        self.searchController = searchController
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func showLoadingView() {
        showLoading()
    }

    func hideLoadingView() {
        hideLoading()
    }

    func reloadData() {
        restaurantsCollectionView.reloadData()
    }

    func endRefreshing() {
        restaurantsCollectionView.refreshControl?.endRefreshing()
    }

    func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }

    func addRefreshControl() {
       let refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
       restaurantsCollectionView.refreshControl = refreshControl
   }
}

extension HomeViewController: RestaurantCollectionDelegate {
    func favoriteButtonTapped() {
      print("favoriteButtonTapped")
    }
}

extension HomeViewController:  SearchSuggestionDelegate {
    func searchSuggestionItemTapped(item: SearchItem) {
        print("searchSuggestionItemTapped: \(item.title)")
        searchController?.isActive = false
    }
}
