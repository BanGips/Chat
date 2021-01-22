//
//  ListViewController.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit

//3
struct MChat: Hashable {
    var userName: String
    var userImage: UIImage
    var lastMessage: String
    
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.id == rhs.id
    }
}

class ListViewController: UIViewController {

    var collectionView: UICollectionView!
    
    //2
    var dataSource: UICollectionViewDiffableDataSource<Sections, MChat>?
    
    // 3
    enum Sections: Int, CaseIterable {
        case activeChats
    }
    
    let activeChats = [MChat(userName: "Musha", userImage: UIImage(), lastMessage: "Heelo noob"),
                       MChat(userName: "Dendi", userImage: UIImage(), lastMessage: "Heelo pro"),
                       MChat(userName: "finrir", userImage: UIImage(), lastMessage: "Heelo acc")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainWhite()
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createComposLayout())
        collectionView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    // 4
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Sections(rawValue: indexPath.section) else { fatalError("No Sections") }
            
            switch section {
            case .activeChats:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
                cell.backgroundColor = .blue
                return cell
            }
        })
    }
    
    // 5
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, MChat>()
        snapshot.appendSections([.activeChats])
        snapshot.appendItems(activeChats, toSection: .activeChats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    // 1
    private func createComposLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionInsex, layoutEnvironmemt) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(86))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize , subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
            
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10)
            
            return section
        }
        return layout
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}



// MARK: - SwiftUI
import SwiftUI

struct ListControllerProvider: PreviewProvider {
    
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        }
    }
}

