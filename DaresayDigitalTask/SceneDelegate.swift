//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		setupAppWindow(in: windowScene)
	}
	
	private func setupAppWindow(in windowScene: UIWindowScene) {
		let manager = HTTPNetworkManager()
//		manager.isLogginEnabled = true
		
		let tmdbDataSource = TheMovieDBNetworkDataSource(service: .default(), manager: manager)
		let storage = InMemoryStorage<[Movie]>(initialObject: [])
		let controller = MainTabBarScene.build(with: .init(
			popularMoviesDataSource: tmdbDataSource,
			topRatedMoviesDataSource: tmdbDataSource,
			favoriteMoviesManager: FavoriteMoviesManager(storage: storage)
		))
		
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = controller
		window?.makeKeyAndVisible()
	}

}

