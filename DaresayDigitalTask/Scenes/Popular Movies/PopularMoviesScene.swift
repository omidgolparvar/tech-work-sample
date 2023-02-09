//

import Foundation
import UIKit

enum PopularMoviesScene: SceneBuilder {
	
	struct BuildConfiguration {
		let dataSource: TheMovieDBPopularMoviesDataSource
	}
	
	struct State: StateProtocol {
		var fetchMoviesStatus = RequestStatus<PaginationResponse<Movie>>.idle
	}
	
	enum Action {
		case fetchMovies
	}
	
	typealias Controller = PopularMoviesViewController
	
	static func build(with configuration: BuildConfiguration) -> Controller {
		let viewModel = PopularMoviesViewModel(dataSource: configuration.dataSource)
		let controller = Controller(viewModel: viewModel)
		
		return controller
	}
	
}
