//

import Foundation
import UIKit
import Combine

final class PopularMoviesViewController: SceneController<PopularMoviesScene.State, PopularMoviesScene.Action> {
	
	private var collectionView: UICollectionView!
	private var dataSource: DataSource!
	
}

extension PopularMoviesViewController {
	
	typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieViewModel>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewModel>
	
	enum Section: Hashable {
		case main
	}
	
	private func configureCollectionView() {
		
	}
	
	private func makeDataSource() -> DataSource {
		DataSource.init(collectionView: collectionView, cellProvider: collectionViewCellProvider(collectionView:indexPath:item:))
	}
	
	private func collectionViewCellProvider(
		collectionView: UICollectionView,
		indexPath: IndexPath,
		item: MovieViewModel
	) -> UICollectionViewCell? {
		return nil
	}
	
	func applySnapshot(animatingDifferences: Bool = true) {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems([])
		dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
	}
	
}
