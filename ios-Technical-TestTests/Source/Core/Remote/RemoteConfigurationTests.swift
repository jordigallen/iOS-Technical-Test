//
//  RemoteConfigurationTest.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 23/3/21.
//

import Nimble
import XCTest
@testable import ios_Technical_Test

final class RemoteConfigurationTests: XCTestCase {
    func testRemoteConfigurationInstanceConstructor() {
        let remoteConfiguration = RemoteConfiguration(baseUrl: "URL_TEST")
        expect(remoteConfiguration).notTo(beNil())
    }
}
 
