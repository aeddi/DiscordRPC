import Foundation

func generateNonce(async: Bool = false) -> String {
    return "\(async ? "async" : "sync");\(UUID().uuidString)"
}

func isNonceAsync(nonce: String) throws -> Bool {
    let components = nonce.components(separatedBy: ";")
    if components.count != 2 || (components[0] != "async" && components[0] != "sync") {
        throw NonceError.invalid(nonce: nonce)
    }
    return components[0] == "async"
}
