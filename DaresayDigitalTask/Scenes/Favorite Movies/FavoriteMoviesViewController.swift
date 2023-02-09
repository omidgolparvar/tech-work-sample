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
		let collectionViewLayout = makeCollectionViewLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
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
		
		title = "Favorite Movies"
		tabBarItem = .init(title: "Favorites", image: .init(sfSymbol: "heart", scale: .large), selectedImage: .init(sfSymbol: "heart.fill", scale: .large))
		tabBarItem.tag = 0
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
		
	}
	
	// MARK: - Helper Methods
	
	private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: SimpleMovieViewModel) -> UICollectionViewCell? {
		let cell = collectionView.dequeueReusableCell(ofType: UICollectionViewCell.self, for: indexPath)
		cell.contentConfiguration = MovieListStyleContentView.Configuration(movieViewModel: item)
		return cell
	}
	
	private func makeCollectionViewLayout() -> UICollectionViewLayout {
		let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
		let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
		let group: NSCollectionLayoutGroup
		if #available(iOS 16, *) {
			group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: layoutItem, count: 1)
		} else {
			group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: 1)
		}
		group.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
		
		let section = NSCollectionLayoutSection(group: group)
		let layout = UICollectionViewCompositionalLayout(section: section)
		
		return layout
	}
	
	private func addSnapshot(with items: [SimpleMovieViewModel]) {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems(items, toSection: .main)
		dataSource.apply(snapshot)
	}
	
}

// MARK: - UICollectionViewDelegate

extension FavoriteMoviesViewController: UICollectionViewDelegate {
	
}
