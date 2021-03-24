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
    let remoteManager = RemoteManager(RemoteConfiguration(baseUrl: "test"))

    func testRemoteConfigurationInstanceConstructor() {
        let remoteConfiguration = RemoteConfiguration(baseUrl: "URL_TEST")
        expect(remoteConfiguration).notTo(beNil())
    }

    func testRemoteGet(){
        self.remoteManager.get("test", parameters: nil) { (result: Swift.Result<[TVShowModel], BaseError>) in
            switch result {
            case let .success(value):
                expect(value).notTo(beNil())
            case .failure(_): break
            }
        }
    }

    func testRemotePost(){
        self.remoteManager.post("test", parameters: nil) { (result: Swift.Result<[TVShowModel], BaseError>) in
            switch result {
            case let .success(value):
                expect(value).notTo(beNil())
            case .failure(_): break
            }
        }
    }

    func testRemoteDelete(){
        self.remoteManager.delete("test", parameters: nil) { (result: Swift.Result<[TVShowModel], BaseError>) in
            switch result {
            case let .success(value):
                expect(value).notTo(beNil())
            case .failure(_): break
            }
        }
    }

    func testRemotePut(){
        self.remoteManager.put("test", parameters: nil) { (result: Swift.Result<[TVShowModel], BaseError>) in
            switch result {
            case let .success(value):
                expect(value).notTo(beNil())
            case .failure(_): break
            }
        }
    }
}
 
