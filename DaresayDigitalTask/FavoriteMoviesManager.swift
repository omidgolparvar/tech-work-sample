//

import Foundation

protocol FavoriteMoviesManagerProtocol {
	var favorites: [Movie] { get }
	func isFavorite(movie: Movie) -> Bool
	func addToFavorite(movie: Movie) -> Bool
}

class FavoriteMoviesManager: FavoriteMoviesManagerProtocol {
	
	private let storage: any Storage<[Movie]>
	
	var favorites: [Movie] {
		favoriteMovies()
	}
	
	init(storage: any Storage<[Movie]>) {
		self.storage = storage
	}
	
	func isFavorite(movie: Movie) -> Bool {
		favorites.contains(movie)
	}
	
	@discardableResult
	func addToFavorite(movie: Movie) -> Bool {
		guard case .success(var movies) = storage.currentObject() else { return false }
		
		let newValue = movies.flatMap { $0 + [movie] } ?? [movie]
		
		guard case .success = storage.store(object: newValue) else { return false }
		return true
	}
	
	private func favoriteMovies() -> [Movie] {
		guard case .success(let movies?) = storage.currentObject() else { return [] }
		return movies
	}
	
}
