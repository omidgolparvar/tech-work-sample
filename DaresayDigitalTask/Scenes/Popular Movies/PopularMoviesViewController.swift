//

import Foundation
import UIKit
import Combine

final class PopularMoviesViewController: UIViewController, SceneController {
	
	// MARK: - Models
	
	typealias State = PopularMoviesScene.State
	typealias Action = PopularMoviesScene.Action
	
	private typealias DataSource = UICollectionViewDiffableDataSource<Section, SimpleMovieViewModel>
	private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SimpleMovieViewModel>
	
	private enum Section: Hashable {
		case main
	}
	
	// MARK: - Subviews
	
	private lazy var collectionView: UICollectionView = {
		let collectionViewLayout = MovieCollectionViewStyle.grid()
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
		
		title = "Popular Movies"
		tabBarItem = .init(title: "Popular", image: .init(sfSymbol: "p.square", scale: .large), selectedImage: .init(sfSymbol: "p.square.fill", scale: .large))
		tabBarItem.tag = 0
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemGroupedBackground
		navigationItem.largeTitleDisplayMode = .always
		
		setupViews()
		setupBindings()
		
		viewModel.handle(action: .fetchMovies)
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
			.map(\.fetchMoviesStatus)
			.removeDuplicates()
			.sink { [weak self] status in
				guard let self else { return }
				self.handleFetchMoviesRequestStatus(status: status)
			}
			.store(in: &cancellables)
	}
	
	// MARK: - Helper Methods
	
	private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: MovieViewModel) -> UICollectionViewCell? {
		let cell = collectionView.dequeueReusableCell(ofType: UICollectionViewCell.self, for: indexPath)
		cell.contentConfiguration = MovieGridStyleContentView.Configuration(movieViewModel: item)
		return cell
	}
	
	private func addSnapshot(with items: [SimpleMovieViewModel]) {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems(items, toSection: .main)
		dataSource.apply(snapshot)
	}
	
	private func handleFetchMoviesRequestStatus(status: RequestStatus<PaginationResponse<Movie>>) {
		switch status {
		case .idle:
			print(#function, status.debugDescription)
			
		case .loading:
			print(#function, status.debugDescription)
			
		case .failed(let error):
			print(#function, "Error:", error.localizedDescription)
			addErrorMessageView(for: error)
			
		case .loaded(let model):
			print(#function, "Items:", model.results.count)
			addSnapshot(with: model.results.map({ SimpleMovieViewModel.init(movie: $0, isFavorite: false) }))
		}
	}
	
	private func addErrorMessageView(for error: Error) {
		messageView?.removeFromSuperview()
		messageView = MessageView(contentConfiguration: .presetError(error, action: {
			print(#function)
		}))
		messageView!.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(messageView!)
		view.bringSubviewToFront(messageView!)
		
		NSLayoutConstraint.activate([
			messageView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			messageView!.topAnchor.constraint(equalTo: view.topAnchor),
			messageView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			messageView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
}

// MARK: - UICollectionViewDelegate

extension PopularMoviesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(#function, "IndexPath:", indexPath)
	}
}
