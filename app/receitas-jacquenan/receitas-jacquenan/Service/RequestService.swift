//
//  RequestService.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 14/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation

protocol RequestServiceDelegate: AnyObject {
    func didReceiveData(_ data: Data)
}

class RequestService: NSObject {
    
    private var requestSession: URLSession?
    private var dataTask: URLSessionDataTask?
    weak var delegate: RequestServiceDelegate?
    
    private var apiURL: String = "https://crawler-jacquenan.herokuapp.com/"
    
    init(_ delegate: RequestServiceDelegate) {
        super.init()
        
        self.delegate = delegate
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        requestSession = URLSession(configuration: config,
                                    delegate: self,
                                    delegateQueue: nil)
    }
    
    func getRecipe(_ url: String) {
        guard let url = URL(string: "\(self.apiURL)/recipe?recipe=\(url)") else { return }
        
        let task = self.requestSession?.dataTask(with: url)
        task?.resume()
    }
    
}

// MARK: - DataDelegate
extension RequestService: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // Receive request
        self.delegate?.didReceiveData(data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print(response)
        completionHandler(.allow)
    }
        
}

// MARK: - TaskDelegate
extension RequestService: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // Do something while waiting for connectivity
    }
    
}
