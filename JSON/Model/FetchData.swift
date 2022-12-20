//
//  FetchData.swift
//  JSON
//
//  Created by Swope, Thomas on 12/12/22.
//

import Foundation

class FetchData: ObservableObject{
    
    @Published var response: Response = Response()
    
    func getData(){
        
        // create a string that contains the URL for our API request.
        let URLString = "https://newsapi.org/v2/everything?q=nfl&from=2022-12-12&sortBy=publishedAt&apiKey=948d8f533bf6439d94f891fae25ccf45"
        
        // initialize a URL object from the string
        guard let url = URL(string: URLString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                if let e = error{
                    print(e.localizedDescription)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let r = try decoder.decode(Response.self, from: jsonData)
                self.response = r
            } catch {
                print("\(error)")
            }
            
            //guard let dataString = String(data: d, encoding: .utf8) else {return}
            //print(dataString)
        }.resume()
    }
    
}
// update so that you decode source name, author, description, url, urlToImage, and content
// update display so that you can see the author and source name as well as the title

struct Response: Codable{
    var totalResults: Int = 0
    var articles: [Article] = []
}

struct Article: Codable{
    var title: String = ""
}

extension Article: Identifiable{
    var id: String {title}
}
    
/*    func decodeJSON(){
        // add a third property, which would be their phone number.
        // update the Codable struct
        // update the content view so that it displays firstName, lastName and phone number
        let jsonData = """
        {"people": [
            { "firstName" : "Thomas",
              "lastName" : "Swope",
              "address" : {
                    "street": "123 Happy St.",
                    "city": "Anytown",
                    "state": "PA",
                    "zip": "55555"
                }
            },
            { "firstName" : "Laurie",
              "lastName" : "Swope",
              "address" : {
                    "street": "123 Happy St.",
                    "city": "Anytown",
                    "state": "PA",
                    "zip": "55555"
                }
            },
            { "firstName" : "Zach",
              "lastName" : "Swope",
              "address" : {
                    "street": "123 Happy St.",
                    "city": "Anytown",
                    "state": "PA",
                    "zip": "55555"
                }
            },
            { "firstName" : "Ellie",
              "lastName" : "Swope",
              "address" : {
                    "street": "123 Happy St.",
                    "city": "Anytown",
                    "state": "PA",
                    "zip": "55555"
                }
            }
        ]}
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do{
            let p = try decoder.decode(People.self, from: jsonData)
            people = p
        } catch {
            print("\(error)")
        }
    }
}

struct People: Codable{
    var people: [Person] = []
}

struct Person: Codable{
    var firstName: String = ""
    var lastName: String = ""
    var address: Address = Address()
}

struct Address: Codable{
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
}

extension Person: Identifiable{
    var id: String {return firstName + lastName}
}
 */
