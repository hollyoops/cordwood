import SwiftUI
import RecoilSwift
import BooksContracts

struct FilterOptionsView: HookView {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var hookBody: some View {
        let selectedCategoryState = useRecoilState(ProductStore.selectedCategoryState)
        
        VStack {
            List(BookCategory.allCases, id: \.self) { category in
                HStack {
                    Button(category.rawValue.capitalized) {
                        selectedCategoryState.wrappedValue = category
                        mode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                    
                    if selectedCategoryState.wrappedValue == category {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                    }
                }
            }
            
            Button(action: {
                selectedCategoryState.wrappedValue = nil
                mode.wrappedValue.dismiss()
            }, label: {
                Text("Reset")
                    .foregroundColor(Color.white)
            })
            .frame(width: 200, height: 60)
            .background(Color.red)
            .cornerRadius(8)
            .layoutPriority(999)
            
            Spacer()
            
        }.background(Color(white: 0.949))
    }
}
