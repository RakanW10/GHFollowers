//
//  FavoritesVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private lazy var tableView = UITableView()
    private var favorites: [Follower] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    // MARK:  Methods
    private func getFavorites(){
        PersistenceManger.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if (favorites.isEmpty){
                    showEmptyStateView(with: "No Favorites.\nAdd one on the follower screen", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong",  message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    // MARK:  Configurations
    private func configure(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
}


// MARK:  UITableView Delegate/DataSource
extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.set(favorite:favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = self.favorites[indexPath.row]
        let destVC = FollowersListVC(username: favorite.login)
        destVC.navigationController?.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = self.favorites[indexPath.row]
        
        PersistenceManger.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                if(favorites.isEmpty){
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "No Favorites.\nAdd one on the follower screen", in: self.view)

                    }
                }
                return
            }
            presentGFAlertOnMainThread(alertTitle: "Unable to delete", message: error.rawValue, buttonTitle: "Ok")
        }

    }
    
}
