import SwiftUI

struct Network: View {
    @StateObject var viewModel = CoinsViewModel()
    
    var body: some View {
        Text("\(viewModel.coin): \(viewModel.price)")
    }
}

#Preview {
    Network()
}
