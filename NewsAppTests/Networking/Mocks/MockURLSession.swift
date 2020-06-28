//
//  MockURLSession.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 28/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation
@testable import NewsApp

final class MockURLSession: URLSessionProtocol {
    let behavior: Behavior
    private var statusCode: Int {
        switch behavior {
        case .success:
            return 200
        default:
            return 401
        }
    }
    
    init(behavior: Behavior) {
        self.behavior = behavior
    }
    
    func dataTask(with request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        guard let path = Bundle.main.path(forResource: "MockArticle", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let url = request.url else {
                return MockURLSessionDataTask()
        }
        
        let response: URLResponse? = {
            guard case .success = behavior else {
                return nil
            }
            
            return HTTPURLResponse(url: url,
                                   statusCode: statusCode,
                                   httpVersion: nil,
                                   headerFields: nil)
        }()
        
        let error: Error? = {
            switch behavior {
            case .success:
                return nil
            default:
                return NetworkingError.forbidden
            }
        }()
        
        completion(data, response, error)
        return MockURLSessionDataTask()
    }
}
