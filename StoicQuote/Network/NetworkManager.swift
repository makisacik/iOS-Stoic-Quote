//
//  NetworkManager.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 13.03.2022.
//

import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    var manager = NetworkReachabilityManager(host: "www.google.com")

    fileprivate var isReachable = false

    var components = URLComponents() {
        didSet {
            components.scheme = "https"
            components.host = NetworkConstants.stoicWisdomApiHostString
        }
    }

    var isConnected: Bool {
        if let reachabilityManager = NetworkReachabilityManager() {
            return reachabilityManager.isReachable
        } else {
            return false
        }
    }

    func startMonitoring() {
        self.manager?.startListening(onQueue: DispatchQueue.global(), onUpdatePerforming: { (networkStatus) in
            if networkStatus == .notReachable {
                self.isReachable = false
            } else {
                self.isReachable = true
            }
        })
    }

    func getRandomQuote(completion: @escaping (Result<Quote,AFError>) -> Void) {
        components.path = "/v1/api/quotes/random"
        if let urlString = components.string {
            AF.request(urlString, method: .get).responseDecodable(of: Quote.self) { response in
                completion(response.result)
            }
        }
    }
}
