//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit


protocol FollowerListVCDelegate: AnyObject {
    func shouldUpdateDate(with newUsername: String)
}


class FollowersListVC: UIViewController {
    private enum Section{ case main }
    
    var username: String
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Follower> = {
        var ds = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView)
        { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
        return ds
    }()
    
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK:  UIs
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout.createThreeColumnFlowLayout(in: view))
        cv.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK:  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(page: page)
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK:  Configurations
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        self.title = username
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureSearchBar(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search about username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    // MARK:  Methods
    private func getFollowers(page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingView()
            }
            switch result {
            case .success(let followers):
                if followers.count == 0 {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "This user han no followers 😔", in: self.view)
                    }
                    return
                }
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData(with: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func updateData(with followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        diffableDataSource.apply(snapshot)
    }
    
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.dismissLoadingView()
            }
            switch result {
            case .success(let user):
                let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManger.updateWith(favorite: follower, actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(alertTitle: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


// MARK:  UICollectionViewDelegate
extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreFollowers else { return }
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY + height >= contentHight {
            page += 1
            self.getFollowers(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let navController = UINavigationController(rootViewController: UserInfoVC(username: follower.login, delegate: self))
        present(navController, animated: true)
    }
}


// MARK:  Search Bar
extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { follower in
            follower.login.lowercased().contains(filter.lowercased())
        }
        updateData(with: filteredFollowers)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        if text.isEmpty {
            isSearching = false
            updateData(with: followers)
        }
    }
}

// MARK: FollowerListVCDelegate
extension FollowersListVC: FollowerListVCDelegate {
    func shouldUpdateDate(with newUsername: String) {
        username = newUsername
        self.title = newUsername
        self.followers = []
        self.filteredFollowers = []
        self.page = 1
        self.hasMoreFollowers = true
        self.isSearching = false
        collectionView.setContentOffset(.zero, animated: true) // scroll to top
        getFollowers(page: page)
    }
}
