//
//  Endpoint.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation

final class Endpoint {
    let path: String
    private(set) var queryItems: [URLQueryItem] = []

    init(path: String,
         queryItems: [URLQueryItem]) {

        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "boredapi.com"
        components.path = "/api/" + path

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
}
