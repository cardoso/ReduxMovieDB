//
//  FavoritesStorage.swift
//  ReduxMovieDB
//
//  Created by Aleksei Cherepanov on 05.10.2019.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import Foundation

protocol FavoritesStorage {
    var favorites: [Movie] { get }
    func isFavorite(id: Int) -> Bool
    @discardableResult func toggle(movie: Movie) -> Bool
    func drop()
}

class MemoryFavoritesStorage: FavoritesStorage {
    
    var storage = [Int: Movie]()
    var favorites: [Movie] {
        get {
            return storage.map { $0.value }
        }
        set {
            storage = .init(newValue.map { ($0.id!, $0) },
                            uniquingKeysWith: { first, _ in return first })
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        return storage[id] != nil
    }
    
    func toggle(movie: Movie) -> Bool {
        guard let id = movie.id else { return false }
        if isFavorite(id: id) {
            storage.removeValue(forKey: id)
            return false
        } else {
            storage[id] = movie
            return true
        }
    }
    
    func drop() {
        storage = [Int: Movie]()
    }
}

class UserDefaultsFavoritesStorage: MemoryFavoritesStorage {
    override var storage: [Int: Movie] {
        didSet { save() }
    }
    var defaults: UserDefaults
    var storageKey: String
    
    init(defaults: UserDefaults, key: String) {
        self.defaults = defaults
        self.storageKey = key
        super.init()
        load()
    }
    
    /// Load favorites from UserDefaults
    func load() {
        guard let saved = defaults.object(forKey: storageKey) as? Data else { return }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(Array<Movie>.self, from: saved) else { return }
        favorites = loaded
    }
    
    /// Save favorites from UserDefaults
    func save() {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(favorites)
            defaults.set(encoded, forKey: storageKey)
        } catch {
            print(error.localizedDescription)
        }
   //     guard let encoded = try? encoder.encode(favorites) else { return }
        
    }
}
