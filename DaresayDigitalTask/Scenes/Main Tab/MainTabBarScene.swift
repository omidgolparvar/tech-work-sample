//

import Foundation
import UIKit

enum MainTabBarScene {
	
	struct BuildConfiguration {
		let popularMoviesDataSource: TheMovieDBPopularMoviesDataSource
		let topRatedMoviesDataSource: TheMovieDBTopRatedMoviesDataSource
		let favoriteMoviesManager: FavoriteMoviesManagerProtocol
	}
	
	struct State: StateProtocol {
		
	}
	
	enum Action {
		
	}
	
	typealias Controller = MainTabBarController
	
	static func build(with configuration: BuildConfiguration) -> Controller {
		let viewModel = MainTabBarViewModel()
		
		let controller = Controller(viewModel: viewModel)
		controller.configureViewControllers(with: configuration)
		
		return controller
	}
	
}
