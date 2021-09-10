import SwiftUI
import RecoilSwift
import BooksContracts

struct BooksContent: HookView {
    let addClick: (Book) -> Void
    
  var hookBody: some View {
    let loadable = useRecoilValueLoadable(ProductStore.currentBooks)
    
    return VStack {
      if loadable.isLoading {
        Text("Fetch books...")
        ProgressView()
          .padding(.vertical, 10)
      } else if let currentBooks = loadable.data {
        VStack(alignment: .leading, spacing: 8) {
          FilterInfoView()
            .padding([.leading], 24)
          allBooks(books: currentBooks)
        }
      }
    }
  }
  
  private func allBooks(books: [Book]) -> some View {
    return List(books) { book in
      HStack {
          VStack(alignment: .leading) {
            Text(book.name)
              Spacer()
            Text("Category: \(book.category.rawValue)")
                  .font(.system(size: 13))
                  .foregroundColor(.gray)
          }
      
        Spacer()
        Button(action: {
            addClick(book)
        }) {
          Image(systemName: "cart.fill.badge.plus")
                .resizable()
                .frame(width: 32.0, height: 26.0)
        }
      }
      .padding()
      .buttonStyle(PlainButtonStyle())
    }
  }
}
