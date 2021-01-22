//
//  ListViewController.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit

//3
struct MChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
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
        case waitingChats
        case activeChats
    }
    
    let activeChats = Bundle.main.decode([MChat].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([MChat].self, from: "waitingChats.json")
    
    
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID2")
    }
    
    // 4
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Sections(rawValue: indexPath.section) else { fatalError("No Sections") }
            
            switch section {
            case .waitingChats:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath)
                cell.backgroundColor = .red
                return cell
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
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)
        dataSource?.apply(snapshot, animatingDifferences: true)
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

extension ListViewController {
    
    // 1
    private func createComposLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionInsex, layoutEnvironmemt) -> NSCollectionLayoutSection? in
            
            guard let section = Sections(rawValue: sectionInsex) else { fatalError("No Sections") }
            
            switch section {
            case .waitingChats:
                return self.createWaitingChats()
            case .activeChats:
                return self.createActiveChats()
            }
        }
        return layout
    }
    
    // 6
    private func createWaitingChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize , subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize , subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 10)
        
        return section
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
