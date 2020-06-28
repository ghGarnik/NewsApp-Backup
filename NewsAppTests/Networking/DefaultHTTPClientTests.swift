//
//  DefaultHTTPClientTests.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 28/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import XCTest
@testable import NewsApp

class DefaultHTTPClientTests: XCTestCase {
    
    var sut: HTTPClient!
    var articleId: String!
    
    
    override func setUp() {
        super.setUp()
        articleId = "127"
    }
    
    override func tearDown() {
        articleId = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testRequestRetrievesArticle() {
        let dependencies = successfulDependencies
        sut = DefaultHTTPClient(dependencies: dependencies)
        let path = Endpoints.articlesList.url.appending(("/\(String(articleId))"))
        let request = ArticleDetailRequest(path: path)
        
        sut.execute(request,
                    parameters: nil) { result in
                        switch result {
                        case .successful(let response):
                            guard let response = response else {
                                XCTFail()
                                return
                            }
                            XCTAssert(response.id == 1 , "Incorrect response")
                        case .failure:
                            XCTFail()
                        }
        }
    }
    
    func testRequestFailsIfInvalidSession() {
        let dependencies = notAuthenticatedDependencies
        sut = DefaultHTTPClient(dependencies: dependencies)
        let path = Endpoints.articlesList.url.appending(("/\(String(articleId))"))
        let request = ArticleDetailRequest(path: path)
        
        sut.execute(request,
                    parameters: nil) { result in
                        switch result {
                        case .successful:
                            XCTFail("Request succedded even if invalid session")
                        case .failure(let error):
                            XCTAssertEqual(error, NetworkingError.forbidden)
                        }
        }
    }
    
    private var successfulDependencies: DefaultHTTPClientDependenciesProtocol {
        let sessionManager = MockDefaultSessionManager(behavior: .success)
        let urlSession = MockURLSession(behavior: .success)
        let dependencies = MockDefaultHTTPClientDependencies(sessionManager: sessionManager,
                                                         urlSession: urlSession)
        return dependencies
    }
    
    private var notAuthenticatedDependencies: DefaultHTTPClientDependenciesProtocol {
        let sessionManager = MockDefaultSessionManager(behavior: .fail)
        let urlSession = MockURLSession(behavior: .success)
        let dependencies = MockDefaultHTTPClientDependencies(sessionManager: sessionManager,
                                                         urlSession: urlSession)
        return dependencies
    }
}
