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
		let topRatedMoviesController = TopRatedMoviesScene.build(with: .init(dataSource: configuration.topRatedMoviesDataSource))
		
		viewControllers = [popularMoviesController, topRatedMoviesController]
	}
	
	func setupViews() {
		print(#function)
	}
	
	func setupBindings() {
		print(#function)
	}
	
}
