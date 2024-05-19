//
//  User.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 10/11/1445 AH.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let createdAT: String
}
