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
    
    /// Creates a task to request the api for the recipe
    /// - Parameter url: the url of tastemade's recipe
    func getRecipe(_ url: String) {
        guard let url = URL(string: "\(self.apiURL)/recipe?recipe=\(url)") else { return }
        
        let task = self.requestSession?.dataTask(with: url)
        task?.resume()
    }
    
}

// MARK: - DataDelegate
extension RequestService: URLSessionDataDelegate {
    
    /// Receive the api's answer and calls the delegate
    /// - Parameters:
    ///   - session: the shared session
    ///   - dataTask: task responsable
    ///   - data: data requested for the api
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // Receive request
        self.delegate?.didReceiveData(data)
    }
    
    /// Just receives an answer for the request and connect the task with the app
    /// - Parameters:
    ///   - session: the shared session
    ///   - dataTask: task responsable
    ///   - response: api's response (200, 404, etc)
    ///   - completionHandler: depending on the answer, proceed the task to connect with the app
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(.allow)
    }
        
}

// MARK: - TaskDelegate
extension RequestService: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // Do something while waiting for connectivity
    }
    
}
