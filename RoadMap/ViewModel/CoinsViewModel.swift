import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    
    init() {
        fetchPrice(coin: "ethereum")
    }
    
    func fetchPrice(coin: String) {
        print(Thread.current)
        
        let fiat = "usd"
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=\(fiat)"
        guard let url = URL(string: urlString) else { return }
        
        print("Fetching price...")
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(Thread.current)
            print("Did receive data \(String(describing: data))")
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
            print("JSON \(jsonObject)")
            
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return
            }
            print("\(value)")
            
            guard let price = value[fiat] else { return }
            
            DispatchQueue.main.async {
                print(Thread.current)
                
                self.coin = coin.capitalized
                self.price = "₽\(price)"
            }
        }.resume()
        
        print("Did reach end of function")
    }
}
