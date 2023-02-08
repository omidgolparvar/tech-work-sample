//

import Foundation
import UIKit

extension UICollectionView {
	
	typealias CollectionViewCell = UICollectionViewCell & Reusable
	
	func register<Cell: CollectionViewCell>(_ CellType: Cell.Type) {
		register(CellType.self, forCellWithReuseIdentifier: CellType.reuseIdentifier)
	}
	
	func dequeueReusableCell<Cell: CollectionViewCell>(ofType CellType: Cell.Type, for indexPath: IndexPath) -> UICollectionViewCell {
		dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier, for: indexPath) as! Cell
	}
	
}
