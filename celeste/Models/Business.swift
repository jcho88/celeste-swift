//
//  Business.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import Foundation

struct Businesses: Codable {
    var businesses = [Business]()
}

struct Business: Codable {
    
    var id: String
    var alias: String
    var name: String
    
}

class YelpApi: ObservableObject {
    @Published var businesses = Businesses()
    
    func getBusinessByName(completion:@escaping (Businesses) -> ()) {
        
        guard let url = URL(string: "https://api.yelp.com/v3/businesses/matches?name=Sushi%20Nakazawa&address1=23%20Commerce%20St%20New%20York,%20NY%2010014&city=New%20York&state=NY&country=US") else {
            print("Invalid url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer " + "qagBspzDirZ3aSQ1e_T4pLSmFx4Y1xeWql9skdI8up2R3JczCXFxWwLOcECGKrscFv0ZLfgQfk1p3wd0dRJTft5yICI471mwQONSrms8FaiZxIKCGm8D0BJ3di8UYnYx", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            let businesses = try! JSONDecoder().decode(Businesses.self, from: data!)
            print(businesses)
            DispatchQueue.main.async {
                completion(businesses)
            }
        }.resume()
        
    }
}
