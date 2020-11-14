//
//  TypeAliases.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Alamofire
import Foundation

public typealias RemoteCompletionTypeAlias<Response: Codable> = (Swift.Result<Response, BaseError>) -> Void

public typealias EmptyCompletionTypeAlias = (Swift.Result<Void, Error>) -> Void
