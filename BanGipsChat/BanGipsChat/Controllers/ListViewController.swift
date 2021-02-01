//
//  ListViewController.swift
//  BanGipsChat
//
//  Created by BanGips on 22.01.21.
//

import UIKit
import FirebaseFirestore
//3 model

class ListViewController: UIViewController {

    var collectionView: UICollectionView!
    
    //2
    var dataSource: UICollectionViewDiffableDataSource<Sections, MChat>?
    
    // 3
    enum Sections: Int, CaseIterable {
        case waitingChats
        case activeChats
        
        func description() -> String {
            switch self {
            case .waitingChats:
                return "Waiting Chats"
            case .activeChats:
                return "Active Chats"
            }
        }
    }
    
    let activeChats = [MChat]()
    var waitingChats = [MChat]()
    
    private var waitingChatListener: ListenerRegistration?
    
    private let currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        title = currentUser.username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainWhite()
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
        
        waitingChatListener = ListenerService.shared.waitingChatsObserve(chats: waitingChats, completion: { (result) in
            switch result {
            case .success(let chats):
                if self.waitingChats != [], self.waitingChats.count <= chats.count {
                    let chatRequestVC = ChatRequestViewController(chat: chats.last!)
                    chatRequestVC.delegate = self
                    self.present(chatRequestVC, animated: true)
                }
                self.waitingChats = chats
                self.reloadData()
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        })
    }
    
    deinit {
        waitingChatListener?.remove()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createComposLayout())
        collectionView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.register(forType: ActiveChatCell.self)
        collectionView.register(forType: WaitingChatCell.self)
        collectionView.registerHeader(forType: SectionHeader.self)
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

//MARK: - SetupDataSource
extension ListViewController {
    
    // 4
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Sections(rawValue: indexPath.section) else { fatalError("No Sections") }
            
            switch section {
            case .waitingChats:
                let cell = collectionView.dequeueReusableCell(WaitingChatCell.self, for: indexPath)
                cell.configure(with: chat)
                return cell
            case .activeChats:
                let cell = collectionView.dequeueReusableCell(ActiveChatCell.self, for: indexPath)
                cell.configure(with: chat)
                return cell
            }
        })
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader

            guard let section = Sections(rawValue: indexPath.section) else { fatalError("No sections")}

            sectionHeader.configure(text: section.description(), font: .laoSangamMN20(), textColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            return sectionHeader
        }
    }
}

// MARK: - Setup Layout
extension ListViewController {
    
    // 1
    private func createComposLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironmemt) -> NSCollectionLayoutSection? in
            
            guard let section = Sections(rawValue: sectionIndex) else { fatalError("No Sections") }
            
            switch section {
            case .waitingChats:
                return self.createWaitingChatsSize()
            case .activeChats:
                return self.createActiveChatsSize()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    // 6
    private func createWaitingChatsSize() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize , subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createActiveChatsSize() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize , subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)

        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHearedSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
        let sectionHeared = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHearedSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeared
    }
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let chat = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        guard let section = Sections(rawValue: indexPath.section) else { return }
        
        switch section {
        case .waitingChats:
            let chatRequestVC = ChatRequestViewController(chat: chat)
            chatRequestVC.delegate = self
            self.present(chatRequestVC, animated: true)
        case .activeChats:
            print(indexPath)
        }
    }
}

extension ListViewController: WaitingsChatNavigation {
    func removeWaitingChat(chat: MChat) {
        FirestoreService.shared.deleteWaitingChat(chat: chat) { (result) in
            switch result {
            case .success():
                self.showAlert(with: "Success", and: "chat with \(chat.friendUsername) has been deleted")
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
    func chatToActive(chat: MChat) {
        print(#function)
    }
    
    
}
