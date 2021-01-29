//
//  PeopleViewController.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit
import FirebaseAuth

class PeopleViewController: UIViewController {
    
    let users = [MUser]()
//        Bundle.main.decode([MUser].self, from: "users.json")
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MUser>!
    
    enum Section: Int, CaseIterable {
        case users
        
        func description(usersCound: Int) -> String {
            switch self {
            case .users:
                return "\(usersCound) people nearby"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData(with: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
    }
    
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sing out", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sing Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.keyWindow?.rootViewController = AuthViewController()
            } catch {
                print("error sing out \(error.localizedDescription)")
            }
        }))
        present(alertController, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createComposLayout())
        collectionView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.registerHeader(forType: SectionHeader.self)
        collectionView.register(forType: UserCell.self)
    }
    
    private func reloadData(with searchText: String?) {
        let usersFilter = users.filter { $0.contains(filter: searchText) }
            
        var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
        snapshot.appendSections([.users])
        snapshot.appendItems(usersFilter, toSection: .users)
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

extension PeopleViewController {
    
    private func createComposLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironmemt) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else { fatalError("No Sections") }
            
            switch section {
            case .users:
                return self.createUser()
            }
        }
        
        return layout
    }
    
    private func createUser() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHearedSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let sectionHeared = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHearedSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeared
    }
}

//MARK: - SetupDataSource
extension PeopleViewController {
    
    // 4
    private func createDataSource() {
    
        dataSource = UICollectionViewDiffableDataSource<Section, MUser>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("No Sections") }
            
            switch section {
            case .users:
                let cell = collectionView.dequeueReusableCell(UserCell.self, for: indexPath)
                cell.configure(with: chat)
                return cell
            }
            
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader

            guard let section = Section(rawValue: indexPath.section) else { fatalError("No sections")}

            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .users)
            sectionHeader.configure(text: section.description(usersCound: items.count), font: .systemFont(ofSize: 36, weight: .light), textColor: .label)
            return sectionHeader
        }
    }
}

extension PeopleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
    }
    
}




// MARK: - SwiftUI
import SwiftUI

struct PeopleControllerProvider: PreviewProvider {
    
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
