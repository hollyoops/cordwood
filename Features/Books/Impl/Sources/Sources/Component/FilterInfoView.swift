import SwiftUI
import RecoilSwift

struct FilterInfoView: HookView {
    var hookBody: some View {
        let selectedCategoryState = useRecoilState(ProductStore.selectedCategoryState)
        let value = selectedCategoryState.wrappedValue?.rawValue ??  "None"
        
        HStack {
            Text(verbatim: "Selected Category: ")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(.primary)
            
            Text("\(value.capitalized)")
                .foregroundColor(.cyan)
        
            Spacer()
        }
    }
}
