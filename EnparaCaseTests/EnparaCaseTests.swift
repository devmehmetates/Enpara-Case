//
//  EnparaCaseTests.swift
//  EnparaCaseTests
//
//  Created by Mehmet Ateş on 9.08.2022.
//

import XCTest
@testable import EnparaCase

class EnparaCaseTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testGetRequest() throws{
        let expectation = XCTestExpectation(description: #function)
        let testPath = "https://api.themoviedb.org/3/movie/top_rated?api_key=11459cff1c1ce00e3202addab99f3a91&language=en-us&page=1"
        var resultData: Data?
        var resultCode: Int?
        
        NetworkManager<MockModel>.apiRequest(testPath, method: .get, parameters: nil) { response in
            switch response {
                
            case .success(let responseData):
                resultData = responseData.data
                resultCode = responseData.code
                expectation.fulfill()
            case .failure(let error):
                XCTFail("The get process was be failed by:\(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssert(resultData != nil, "Test Passed")
        XCTAssert(resultCode != nil, "Test Passed")
        XCTAssert(resultCode == 200, "Test Passed")
    }
}
