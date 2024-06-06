import SwiftUI

struct Network: View {
    @State var employees = [Employee]()
    @StateObject var networkManager = NetworkManager.shared
    @State var errorMessage = ""
    
    @State var showProgress = false
    @State var showError = false
    
    var body: some View {
        ZStack {
            List(employees, id:\.self) { employee in
                HStack {
                    Text(employee.employee_name)
                    Spacer()
                    Text(employee.employee_salary, format: .number)
                }
            }
            ProgressView()
                .progressViewStyle(.circular)
                .opacity(showProgress ? 1.0 : 0.0)
        }
        .alert(isPresented: $showError, content: {
            Alert(title: Text(errorMessage))
        })
        .onAppear() {
            showProgress = true
            networkManager.fetchEmplyees { result in
                showProgress = false
                switch result {
                    
                case .success(let decodedEmplyees):
                    print("success")
                    
                    employees = decodedEmplyees
                case .failure(let networkError):
                    print("failure: \(networkError)")
                    errorMessage = warningMessage(error: networkError)
                    showError = true
                }
            }
        }
    }
}

#Preview {
    Network()
}
