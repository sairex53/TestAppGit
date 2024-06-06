import Foundation

func warningMessage(error: NetworkError) -> String {
    switch error {
    case .noData:
        return "Data cannot be found at this URL"
    case .tooManyRequests:
        return "429: Too Many requests"
    case .decodingError:
        return "Can't decode data"
    }
}
