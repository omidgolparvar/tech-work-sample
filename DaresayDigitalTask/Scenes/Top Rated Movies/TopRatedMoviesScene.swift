//

import Foundation
import UIKit

enum TopRatedMoviesScene: SceneBuilder {
	
	struct BuildConfiguration {
		let dataSource: TheMovieDBTopRatedMoviesDataSource
	}
	
	struct State: StateProtocol {
		var fetchMoviesStatus = RequestStatus<PaginationResponse<Movie>>.idle
	}
	
	enum Action {
		case fetchMovies
	}
	
	typealias Controller = TopRatedMoviesViewController
	
	static func build(with configuration: BuildConfiguration) -> Controller {
		let viewModel = TopRatedMoviesViewModel(dataSource: configuration.dataSource)
		let controller = Controller(viewModel: viewModel)
		
		return controller
	}
	
}
