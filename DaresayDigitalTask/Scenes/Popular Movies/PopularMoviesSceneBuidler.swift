//

import Foundation

enum PopularMoviesScene {
	
	struct BuildConfiguration {
		let tmdbDataSource: TheMovieDBDataSource
	}
	
	struct State: StateProtocol {
		
	}
	
	enum Action {
		case fetchMovies
	}
	
}

enum PopularMoviesSceneBuidler: SceneBuilder {
	typealias State = PopularMoviesScene.State
	typealias Action = PopularMoviesScene.Action
	typealias BuildConfiguration = PopularMoviesScene.BuildConfiguration
	typealias Controller = PopularMoviesViewController
	
	static func build(with configuration: BuildConfiguration) -> PopularMoviesViewController {
		let viewModel = PopularMoviesViewModel(tmdbDataSource: configuration.tmdbDataSource)
		let controller = Controller(viewModel: viewModel)
		
		return controller
	}
}
