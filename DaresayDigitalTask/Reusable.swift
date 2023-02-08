//

import Foundation
import UIKit

protocol Reusable {
	static var reuseIdentifier: String { get }
}

extension Reusable {
	static var reuseIdentifier: String {
		String(describing: Self.self)
	}
}

extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}
