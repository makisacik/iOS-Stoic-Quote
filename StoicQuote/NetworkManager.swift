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
    private init(){
    }
    
    var manager = NetworkReachabilityManager(host: "www.apple.com")
    
    fileprivate var isReachable = false
    
    var isConnected:Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    
    func startMonitoring(){
        self.manager?.startListening(onQueue: DispatchQueue.global(), onUpdatePerforming: { (networkStatus) in
            if networkStatus == .notReachable {
                self.isReachable = false
            }
            else{
                self.isReachable = true
            }
        })
    }
    

}
