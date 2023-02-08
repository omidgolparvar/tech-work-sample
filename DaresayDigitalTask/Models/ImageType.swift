//

import Foundation

enum ImageType {
	
	private static let baseURL: URL = URL(string: "https://image.tmdb.org/t/p/").unsafelyUnwrapped
	
	case backdrop(ImageSize)
	case logo(ImageSize)
	case poster(ImageSize)
	case profile(ImageSize)
	
	var size: ImageSize {
		switch self {
		case .backdrop(let size),
				.logo(let size),
				.poster(let size),
				.profile(let size):
			return size
		}
	}
	
	func url(forPath path: String) -> URL {
		Self.baseURL.appending(components: size.rawValue, path)
	}
	
	enum PosterSizes {
		static var w92: ImageSize { .w92 }
		static var w154: ImageSize { .w154 }
		static var w185: ImageSize { .w185 }
		static var w342: ImageSize { .w342 }
		static var w500: ImageSize { .w500 }
		static var w780: ImageSize { .w780 }
		static var original: ImageSize { .original }
	}
	
	enum BackdropSize {
		static var w300: ImageSize { .w300 }
		static var w780: ImageSize { .w780 }
		static var w1280: ImageSize { .w1280 }
		static var original: ImageSize { .original }
	}
	
	enum LogoSizes {
		static var w45: ImageSize { .w45 }
		static var w92: ImageSize { .w92 }
		static var w154: ImageSize { .w154 }
		static var w185: ImageSize { .w185 }
		static var w300: ImageSize { .w300 }
		static var w500: ImageSize { .w500 }
		static var original: ImageSize { .original }
	}
	
	enum ProfileSizes {
		static var w45: ImageSize { .w45 }
		static var w92: ImageSize { .w92 }
		static var w154: ImageSize { .w154 }
		static var w185: ImageSize { .w185 }
		static var w300: ImageSize { .w300 }
		static var w500: ImageSize { .w500 }
		static var original: ImageSize { .original }
	}
	
}

extension ImageType {
	
	struct ImageSize: RawRepresentable, Equatable {
		typealias RawValue = String
		
		let rawValue: String
		
		init(rawValue: String) {
			self.rawValue = rawValue
		}
		
		static let original = Self.init(rawValue: "original")
		static let w45 = Self.init(rawValue: "w45")
		static let w92 = Self.init(rawValue: "w92")
		static let w154 = Self.init(rawValue: "w154")
		static let w185 = Self.init(rawValue: "w185")
		static let w300 = Self.init(rawValue: "w300")
		static let w342 = Self.init(rawValue: "w342")
		static let w500 = Self.init(rawValue: "w500")
		static let w780 = Self.init(rawValue: "w780")
		static let w1280 = Self.init(rawValue: "w1280")
	}
	
}
