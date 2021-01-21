//
//  NetworkServ.swift
//  Vk
//
//  Created by Евгений Дербенев on 1/17/21.
//

import Foundation
import Alamofire

class NetworkService {

    let vAPI = MySession.shared.vAPI
    
    func getUserFriends() {
        let urlComponent: URLComponents = {
            var url = URLComponents()
            url.scheme = "https"
            url.host = "api.vk.com"
            url.path = "/method/friends.get"
            url.queryItems = [URLQueryItem(name: "access_token", value: MySession.shared.token),
                              URLQueryItem(name: "v", value: vAPI),
                              URLQueryItem(name: "fields", value: "photo_50")]
            return url
        }()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        if let url  = urlComponent.url {
            let task = session.dataTask(with: url) { (data, _, _) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
                        print(json)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    //получение всех фото
    func getPhotos(for userID: String) {
        let urlComponent: URLComponents = {
            var url = URLComponents()
            url.scheme = "https"
            url.host = "api.vk.com"
            url.path = "/method/photos.getAll"
            url.queryItems = [URLQueryItem(name: "access_token", value: MySession.shared.token),
                              URLQueryItem(name: "v", value: vAPI),
                              URLQueryItem(name: "owner_id", value: userID),
                              URLQueryItem(name: "extended", value: "1")]
            return url
        }()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        if let url  = urlComponent.url {
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data, _, _) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
                        print(json)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getUserGroups() {
        let host = "https://api.vk.com"
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "access_token": MySession.shared.token!,
            "v": vAPI,
            "extended": "1"
        ]
            AF.request(host+path,
                       method: .get,
                       parameters: parameters).responseJSON { (json) in
                            print(json)
                       }
    }
    
    func searchGroups(by caption: String) {
        let host = "https://api.vk.com"
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "access_token": MySession.shared.token!,
            "v": vAPI,
            "q": caption
        ]
            AF.request(host+path,
                       method: .get,
                       parameters: parameters).responseJSON { (json) in
                            print(json)
                       }
    }
    
    func logOut(by caption: String) {
//        let host = "https://api.vk.com"
//        let path = "/method/logout"
//        let parameters: Parameters = [
//            "access_token": MySession.shared.token!,
//            "v": vAPI,
//            "q": caption
//        ]
//            AF.request(host+path,
//                       method: .get,
//                       parameters: parameters).responseJSON { (json) in
//                            print(json)
//                       }
    }
}
