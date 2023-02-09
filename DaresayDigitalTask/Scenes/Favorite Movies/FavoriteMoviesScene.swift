//
//  FavoriteMoviesScene.swift
//  DaresayDigitalTask
//
//  Created by Omid Golparvar on 2/9/23.
//

import Foundation

enum FavoriteMoviesScene: SceneBuilder {
	
	struct BuildConfiguration {
		
	}
	
	struct State: StateProtocol {
		
	}
	
	enum Action {
		
	}
	
	typealias Controller = FavoriteMoviesViewController
	
	static func build(with configuration: BuildConfiguration) -> Controller {
		let viewModel = FavoriteMoviesViewModel()
		let controller = Controller(viewModel: viewModel)
		
		return controller
	}
	
}
