//

import Foundation
import UIKit
import Combine

final class FavoriteMoviesViewController: UIViewController, SceneController {
	
	// MARK: - Models
	typealias State = FavoriteMoviesScene.State
	typealias Action = FavoriteMoviesScene.Action
	
	private typealias DataSource = UICollectionViewDiffableDataSource<Section, SimpleMovieViewModel>
	private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SimpleMovieViewModel>
	
	private enum Section: Hashable {
		case main
	}
	
	// MARK: - Subviews
	
	private lazy var collectionView: UICollectionView = {
		let collectionViewLayout = MovieCollectionViewStyle.list()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	private var messageView: MessageView?
	
	// MARK: - Properties
	
	private var cancellables = Set<AnyCancellable>()
	private lazy var dataSource: DataSource = {
		DataSource(collectionView: collectionView, cellProvider: cellProvider)
	}()
	let viewModel: any ViewModel<State, Action>
	
	// MARK: - Initializer
	
	init(viewModel: any ViewModel<State, Action>) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		title = "Favorite Movies"
		tabBarItem = .init(title: "Favorites", image: .init(sfSymbol: "heart", scale: .large), selectedImage: .init(sfSymbol: "heart.fill", scale: .large))
		tabBarItem.tag = 2
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		navigationItem.largeTitleDisplayMode = .always
		
		setupViews()
		setupBindings()
	}
	
	// MARK: - Setup Views
	
	func setupViews() {
		setupCollectionView()
	}
	
	private func setupCollectionView() {
		guard !collectionView.isDescendant(of: view) else { return }
		
		view.addSubview(collectionView)
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		collectionView.register(UICollectionViewCell.self)
		collectionView.dataSource = dataSource
		collectionView.delegate = self
	}
	
	// MARK: - Setup Bindings
	
	func setupBindings() {
		setupViewModelBindings()
	}
	
	private func setupViewModelBindings() {
		viewModel
			.statePublisher
			.map(\.movies)
			.removeDuplicates()
			.sink { [weak self] movies in
				guard let self else { return }
				self.populateList(with: movies)
			}
			.store(in: &cancellables)
	}
	
	// MARK: - Helper Methods
	
	private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: SimpleMovieViewModel) -> UICollectionViewCell? {
		let cell = collectionView.dequeueReusableCell(ofType: UICollectionViewCell.self, for: indexPath)
		cell.contentConfiguration = MovieListStyleContentView.Configuration(movieViewModel: item)
		return cell
	}
	
	private func populateList(with movies: [SimpleMovieViewModel]) {
		addMoviesToList(with: movies)
		
		if movies.isEmpty {
			let messageViewConfiguration = MessageView
				.Configuration
				.init(emoji: "❤️", title: "No Item", message: "Favorite list is empty", buttonAction: nil)
			let messageView = MessageView(contentConfiguration: messageViewConfiguration)
			messageView.translatesAutoresizingMaskIntoConstraints = false
			
			view.addSubview(messageView)
			view.bringSubviewToFront(messageView)
			
			NSLayoutConstraint.activate([
				messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				messageView.topAnchor.constraint(equalTo: view.topAnchor),
				messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			])
			
			self.messageView = messageView
		} else {
			messageView?.removeFromSuperview()
		}
	}
	
	private func addMoviesToList(with items: [SimpleMovieViewModel]) {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems(items, toSection: .main)
		dataSource.apply(snapshot)
	}
	
}

// MARK: - UICollectionViewDelegate

extension FavoriteMoviesViewController: UICollectionViewDelegate {
	
}
