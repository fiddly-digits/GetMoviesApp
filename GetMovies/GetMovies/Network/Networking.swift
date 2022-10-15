//
//  Networking.swift
//  GetMovies
//
//  Created by Roberto Cruz on 24/08/22.
//

import Foundation

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, response, error)
                return
            }
            completion(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func emptyTask<T: Codable>(with url: URL, of type: T.Type = T.self, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completion: completion)
    }
    
//    func emptyTask(with url: URL, completion: @escaping (Series?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completion: completion)
//    }

}






