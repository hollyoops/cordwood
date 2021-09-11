import SwiftUI
import RecoilSwift
import CartContracts

struct CartContent: HookView {
  var hookBody: some View {
    let items = useRecoilValue(CartStore.allCartItemState)
    
    Group {
      if items.isEmpty {
        emptyView()
      } else {
        cartList(items)
      }
    }
  }
  
  private func emptyView() -> some View {
    Text("No book in cart \n Choose some in bookshop")
      .multilineTextAlignment(.center)
      .font(.headline)
      .foregroundColor(.gray)
  }
  
  private func cartList(_ items: [CartItem]) -> some View {
    HookScope {
      let increaseCount = useRecoilCallback(CartStore.increasItemCount(context:item:))
      let decreaseCount = useRecoilCallback(CartStore.decreasItemCount(context:item:))
      let deleteItem = useRecoilCallback(CartStore.deleteItem(context:atIndex:))
      List {
        ForEach(items) { item in
          HStack {
            Text(item.book.name)
            Spacer()
            
            HStack(spacing: 10) {
              Button {
                decreaseCount(item)
              } label: {
                Image(systemName: "minus.square")
              }
              TextField("", text: .constant(String(item.count)))
                .multilineTextAlignment(.center)
                .frame(width: 20)
                .background(Color.white)
                .border(Color.black)
              Button {
                increaseCount(item)
              } label: {
                Image(systemName: "plus.square")
              }
            }
          }
          .padding()
          .buttonStyle(PlainButtonStyle())
        }
        .onDelete(perform: deleteItem)
      }
    }
  }
}

struct CartContent_Previews: PreviewProvider {
  static var previews: some View {
    CartContent()
  }
}
