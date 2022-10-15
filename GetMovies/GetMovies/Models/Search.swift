//
//  Search.swift
//  GetMovies
//
//  Created by Roberto Cruz on 24/08/22.
//

import Foundation

protocol SearchProtocol: AnyObject {
    func performSearch<T: Codable>(for text: String, page: Int, type: String, completion: @escaping (Response<T>) -> Void)
}

//typealias SearchComplete = (Response<T>) -> Void

enum Response<T: Codable> {
    case success(T)
    case failure(Error)
}

class Search: SearchProtocol {
    var dataTask: URLSessionDataTask?
    
    func performSearch<T: Codable>(for text: String, page: Int, type: String, completion: @escaping (Response<T>) -> Void) {
                if !text.isEmpty {
                    dataTask?.cancel()
                    print("Estoy vacio")
                }
        
        let url: URL = UrlManager(searchText: text, type: type, page: page)
        dataTask = URLSession.shared.emptyTask(with: url, of: T.self, completion: { T, response, error in
            if let error = error as Error? {
                completion(.failure(error))
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(.success(T!))
                }
            }
            self.dataTask?.resume()
        })
        
    }
    private func UrlManager(searchText: String, type: String, page: Int) -> URL{
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlString = "https://api.themoviedb.org/3/search/\(type)?api_key=444cd656b00475d785aa41a9c43b2e44&language=en&page=\(String(page))&query=\(encodedText!)"
        let url = URL(string: urlString)
        return url!
        
    }
    
    
    
}

//class Search: SearchProtocol {
//    enum State {
//        case notSearchedYet
//        case loading
//        case noResults
//        case results([MovieResult])
//    }
//
//    private(set) var state: State = .notSearchedYet
//
//    private var dataTask: URLSessionDataTask?
//
//    func performSearch(for text: String, page: Int, completion: @escaping SearchComplete) {
//        if !text.isEmpty {
//            dataTask?.cancel()
//        }
//
//        state = .loading
//
//        let url = UrlManager(searchText: text, page: page)
//        dataTask = URLSession.shared.emptyTask(with: url) { result, response, error in
//            var success = false
//            var newState = State.notSearchedYet
//
//            print("entre aqui")
//            if let error = error as NSError?, error.code == -999 {
//                return // cancel search
//            }
//            //print(result!.results[0])
//
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let result = result {
//                if result.results.isEmpty {
//                    newState = .noResults
//                } else {
//                    print(result.results)
//                    newState = .results(result.results)
//                }
//                success = true
//            }
//            DispatchQueue.main.async {
//                self.state = newState
//                completion(success)
//            }
//        }
//        dataTask?.resume()
//    }
//
//
//    private func UrlManager(searchText: String, page: Int) -> URL{
//        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=444cd656b00475d785aa41a9c43b2e44&language=en&page=\(String(page))&query=\(encodedText!)"
//        let url = URL(string: urlString)
//        return url!
//
//    }
//}
