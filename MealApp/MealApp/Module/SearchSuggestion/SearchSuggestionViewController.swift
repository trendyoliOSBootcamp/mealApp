//
//  SearchSuggestionViewController.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

protocol SearchSuggestionViewInterface: AnyObject {
    func prepareCollectionView()
    func reload()
    var collectionViewWidth: Double { get }
}

final class SearchSuggestionViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: SearchSuggestionPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SearchSuggestionViewController: SearchSuggestionViewInterface {
    var collectionViewWidth: Double {
        return Double(collectionView.frame.width)
    }
    
    func prepareCollectionView() {
        collectionView.register(cellType: BasicSuggestionCell.self)
        collectionView.register(cellType: RestaurantSuggestionCell.self)
        collectionView.registerView(cellType: SuggestionHeaderView.self)
    }
    
    func reload() {
        collectionView.reloadData()
    }
}

extension SearchSuggestionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch presenter.sectionType(at: indexPath.section) {
        case .restaurant:
            let cell = collectionView.dequeCell(cellType: RestaurantSuggestionCell.self, indexPath: indexPath)
            cell.load(searchItem: presenter.item(at: indexPath))
            return cell
        case .text:
            let cell = collectionView.dequeCell(cellType: BasicSuggestionCell.self, indexPath: indexPath)
            cell.load(item: presenter.item(at: indexPath))
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeView(cellType: SuggestionHeaderView.self, indexPath: indexPath)
        reusableView.load(title: presenter.suggestion(at: indexPath.section)?.title ?? "")
        return reusableView
    }
}

extension SearchSuggestionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.sizeOfItem(at: indexPath)
        return CGSize(width: size.0, height: size.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: presenter.headerSize.0, height: presenter.headerSize.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension SearchSuggestionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchResults(searchText: searchController.searchBar.text)
    }
}
