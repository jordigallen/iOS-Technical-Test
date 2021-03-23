//
//  CoreLog+Tests.swift
//  ios-Technical-TestTests
//
//  Created by Jordi Gallen on 22/3/21.
//

import Nimble
import XCTest
@testable import ios_Technical_Test

final class CoreLogTests: XCTestCase {
    private enum ErrorConstans: Int {
        case server = 503
        case notFound = 404
    }

    private let urlMock = "https://www.electomaps.com"
    private let errorMock = "Error in response request"


    func testCoreLog_Process_ForcetStusCode_503() {
        guard let url = URL(string: urlMock) else {
            return
        }
        let error: () = ErrorManager.process(HTTPURLResponse(url: url, statusCode: ErrorConstans.server.rawValue, httpVersion: nil, headerFields: nil)!)
        expect(error).notTo(beNil())
    }

    func testCoreLog_ForcetStusCode_404() {
        guard let url = URL(string: urlMock) else {
            return
        }
        let error: () = ErrorManager.process(HTTPURLResponse(url: url, statusCode: ErrorConstans.notFound.rawValue, httpVersion: nil, headerFields: nil)!)
        expect(error).notTo(beNil())
    }

    func testCoreLog_Process_Error() {
        let error: () = ErrorManager.process(error: errorMock)
        expect(error).notTo(beNil())
    }

    func testCoreLog_Process_Debug() {
        let error: () = CoreLog().debug("", "")
        expect(error).notTo(beNil())
    }

    func testCoreLog_Process_fault() {
        let error: () = CoreLog().fault("", "")
        expect(error).notTo(beNil())
    }

    func testCoreLog_Process_Info() {
        let error: () = CoreLog().info("", "")
        expect(error).notTo(beNil())
    }
}
