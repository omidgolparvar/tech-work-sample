//

import Foundation
import UIKit
import Combine

final class PopularMoviesViewController: UIViewController, SceneController {
	
	// MARK: - Models
	typealias State = PopularMoviesScene.State
	typealias Action = PopularMoviesScene.Action
	
	private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieViewModel>
	private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewModel>
	
	private enum Section: Hashable {
		case main
	}
	
	// MARK: - Subviews
	
	private lazy var collectionView: UICollectionView = {
		let collectionViewLayout = makeCollectionViewLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		return collectionView
	}()
	
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
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Popular Movies"
		tabBarItem = .init(title: "Popular", image: nil, tag: 0)
		
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
		
		collectionView.dataSource = dataSource
		collectionView.delegate = self
	}
	
	// MARK: - Setup Bindings
	
	func setupBindings() {
		setupViewsBindings()
		setupViewModelBindings()
	}
	
	private func setupViewsBindings() {
		
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
		return nil
	}
	
	private func makeCollectionViewLayout() -> UICollectionViewLayout {
		let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
		let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
		let group: NSCollectionLayoutGroup
		if #available(iOS 16, *) {
			group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: layoutItem, count: 1)
		} else {
			group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: 1)
		}
		
		let section = NSCollectionLayoutSection(group: group)
		let layout = UICollectionViewCompositionalLayout(section: section)
		
		return layout
	}
	
	private func addSnapshot(with items: [MovieViewModel]) {
		
	}
	
	private func handleFetchMoviesRequestStatus(status: RequestStatus<PaginationResponse<Movie>>) {
		print(#function)
	}
	
}

// MARK: - UICollectionViewDelegate

extension PopularMoviesViewController: UICollectionViewDelegate {
	
}
