//
//  ListStub.swift
//  ios-Technical-TestUITests
//
//  Created by JORDI GALLEN RENAU on 18/11/20.
//

enum ListStub {

    static var tvShowErrorEndPointResponse = HttpStubInfo(
        endpoint: "/showsERRORENPOINT",
        filename: "TVShowPage0Responses",
        responseDetail: "Bad request",
        route: "tvShowErrorEndPointResponse",
        statusCode: 404,
        method: .get
    )

    static var tvShowEmptyResponse = HttpStubInfo(
        endpoint: "/showsERROR",
        filename: "TVShowPage0Responses",
        route: "tvShowEmptyResponse",
        method: .get
    )

    static var tvShowPage0Responses = HttpStubInfo(
        endpoint: "/shows?page=0",
        filename: "TVShowPage0Responses",
        route: "tvShowPage0Term",
        method: .get
    )
}
