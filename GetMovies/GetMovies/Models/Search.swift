//
//  Search.swift
//  GetMovies
//
//  Created by Roberto Cruz on 24/08/22.
//

import Foundation

typealias SearchComplete = (Bool) -> Void

class Search {
    enum State {
        case notSearchedYet
        case loading
        case noResults
        case results([MovieResult])
    }
    
    private(set) var state: State = .notSearchedYet
    
    private var dataTask: URLSessionDataTask?
    
    func performSearch(for text: String, page: Int, completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
        }
        
        state = .loading
        
        let url = UrlManager(searchText: text, page: page)
        dataTask = URLSession.shared.emptyTask(with: url) { result, response, error in
            var success = false
            var newState = State.notSearchedYet
            
            print("entre aqui")
            if let error = error as NSError?, error.code == -999 {
                return // cancel search
            }
            print(result!.results[0])

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let result = result {
                if result.results.isEmpty {
                    newState = .noResults
                } else {
                    print(result.results)
                    newState = .results(result.results)
                }
                success = true
            }
            DispatchQueue.main.async {
                self.state = newState
                completion(success)
            }
        }
        dataTask?.resume()
    }

    
    private func UrlManager(searchText: String, page: Int) -> URL{
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=444cd656b00475d785aa41a9c43b2e44&language=en&page=\(String(page))&query=\(encodedText!)"
        let url = URL(string: urlString)
        return url!
        
    }
}
