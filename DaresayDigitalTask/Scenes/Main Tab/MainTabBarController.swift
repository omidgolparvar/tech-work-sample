//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController, SceneController {
	typealias State = MainTabBarScene.State
	typealias Action = MainTabBarScene.Action
	
	let viewModel: any ViewModel<State, Action>
	
	init(viewModel: any ViewModel<State, Action>) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func configureViewControllers(with configuration: MainTabBarScene.BuildConfiguration) {
		let popularMoviesController = PopularMoviesScene.build(with: .init(dataSource: configuration.popularMoviesDataSource))
		let popularMoviesNavigationController = UINavigationController(rootViewController: popularMoviesController)
		popularMoviesNavigationController.navigationBar.prefersLargeTitles = true
		
		let topRatedMoviesController = TopRatedMoviesScene.build(with: .init(dataSource: configuration.topRatedMoviesDataSource))
		let topRatedMoviesNavigationController = UINavigationController(rootViewController: topRatedMoviesController)
		topRatedMoviesNavigationController.navigationBar.prefersLargeTitles = true
		
		let favoriteMoviesController = FavoriteMoviesScene.build(with: .init())
		let favoriteMoviesNavigationController = UINavigationController(rootViewController: favoriteMoviesController)
		favoriteMoviesNavigationController.navigationBar.prefersLargeTitles = true
		
		viewControllers = [
			popularMoviesNavigationController,
			topRatedMoviesNavigationController,
			favoriteMoviesNavigationController
		]
	}
	
	func setupViews() {
		print(#function)
	}
	
	func setupBindings() {
		print(#function)
	}
	
}
