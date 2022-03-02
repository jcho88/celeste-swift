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

struct Business: Codable, Identifiable {
    
    var id: String
    var alias: String
    var name: String
    var image_url: String
    var location: BusinessLocation
    
}

class YelpApi: ObservableObject {
    @Published var businesses = Businesses()
    
    func getBusinessByName(name: String, latitude: Double, longitude: Double, completion:@escaping (Businesses) -> ()) {
        let encodedName = name.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=\(String(describing: encodedName))&latitude=\(String(format: "%.1f", latitude))&longitude=\(String(format: "%.1f", longitude))&limit=1") else {
            print("Invalid url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer " + "qagBspzDirZ3aSQ1e_T4pLSmFx4Y1xeWql9skdI8up2R3JczCXFxWwLOcECGKrscFv0ZLfgQfk1p3wd0dRJTft5yICI471mwQONSrms8FaiZxIKCGm8D0BJ3di8UYnYx", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            let businesses = try! JSONDecoder().decode(Businesses.self, from: data!)
            print(businesses.businesses)
            DispatchQueue.main.async {
                completion(businesses)
            }
        }.resume()
        
    }
}
