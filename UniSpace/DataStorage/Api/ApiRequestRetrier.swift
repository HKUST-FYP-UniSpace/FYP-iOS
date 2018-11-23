//
//  ApiRequestRetrier.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire

class ApiRequestRetrier: RequestRetrier {
    
    init() {}
    
    fileprivate var isAuthorizing = false
    fileprivate var retryQueue = [RequestRetryCompletion]()
    
    
    func should(
        _ manager: SessionManager,
        retry request: Request,
        with error: Error,
        completion: @escaping RequestRetryCompletion) {
        
        guard
            shouldRetryRequest(with: request.request?.url),
            shouldRetryResponse(with: request.response?.statusCode)
            else { return completion(false, 0) }
        
        authorize(with: completion)
    }
    
    
    fileprivate func authorize(with completion: @escaping RequestRetryCompletion) {
        retryQueue.append(completion)
        guard !isAuthorizing else { return }
        isAuthorizing = true
        log.info("Request Retrier", context: "Retry count: \(retryQueue.count)")
        DataStore.shared.authorizeApplication { (user, error) in
            DataStore.shared.userInfo = user
            self.isAuthorizing = false
            self.retryQueue.forEach { $0(true, 0) }
            self.retryQueue.removeAll()
        }
    }
    
    fileprivate func shouldRetryRequest(with url: URL?) -> Bool {
        guard let url = url?.absoluteString else { return false }
        let authPath = ApiRoute.authorize.url()
        return !url.contains(authPath)
    }
    
    fileprivate func shouldRetryResponse(with statusCode: Int?) -> Bool {
        return statusCode == 401
    }
}
