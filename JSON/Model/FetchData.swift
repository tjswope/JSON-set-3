//
//  FetchData.swift
//  JSON
//
//  Created by Swope, Thomas on 12/12/22.
//

import Foundation

class FetchData: ObservableObject{
    
    @Published var response: Response = Response()
    
    func getData() async{
        
        // create a string that contains the URL for our API request.
        let URLString = "https://newsapi.org/v2/everything?q=nfl&from=2022-12-12&sortBy=publishedAt&apiKey=948d8f533bf6439d94f891fae25ccf45"
        
        // initialize a URL object from the string
        guard let url = URL(string: URLString) else {return}
        
        do{
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let r = try JSONDecoder().decode(Response.self, from: data)
            self.response = r
        }catch{
            print(error)
        }
    }
    
}

struct Response: Codable{
    var totalResults: Int = 0
    var articles: [Article] = []
}

struct Article: Codable{
    var title: String = ""
}

extension Article: Identifiable{
    var id: String {self.title}
}
