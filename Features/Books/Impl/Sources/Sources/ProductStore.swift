import RecoilSwift
import BooksContracts
import Combine
import Foundation

// MARK: - Atoms
struct ProductStore {
  static let allBookState = atom { AllBooksService.getAllBooks() }
    
  static let selectedCategoryState = Atom<BookCategory?>(nil)
  static let selectedQuarterState = Atom<Int?>(nil)
}

// MARK: - Selectors
extension ProductStore {
  static let currentBooks = selector { get -> [Book] in
    let books = get(allBookState) ?? []
    if let category = get(selectedCategoryState) {
      return books.filter { $0.category == category }
    }
    return books
  }
}

enum BookError: Error { }
