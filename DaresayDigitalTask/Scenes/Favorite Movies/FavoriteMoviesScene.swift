//
//  FavoriteMoviesScene.swift
//  DaresayDigitalTask
//
//  Created by Omid Golparvar on 2/9/23.
//

import Foundation

enum FavoriteMoviesScene: SceneBuilder {
	
	struct BuildConfiguration {
		let manager: FavoriteMoviesManagerProtocol
	}
	
	struct State: StateProtocol {
		var movies: [SimpleMovieViewModel]
	}
	
	enum Action {
		case fetchMovies
		case remove(Movie)
	}
	
	typealias Controller = FavoriteMoviesViewController
	
	static func build(with configuration: BuildConfiguration) -> Controller {
		let viewModel = FavoriteMoviesViewModel(manager: configuration.manager)
		let controller = Controller(viewModel: viewModel)
		
		return controller
	}
	
}
