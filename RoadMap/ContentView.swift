import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                NavigationLink(destination: Network()) {
                    Text("Network")
                        .foregroundColor(.white)
                        .font(.title2).bold()
                }.frame(width: 200, height: 35)
                    .background(.blue).cornerRadius(10)
                    .padding(.bottom, 30)
            }
        }
        .navigationTitle("RoadMap")
    }
}

#Preview {
    ContentView()
}
