//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 11/11/1445 AH.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
