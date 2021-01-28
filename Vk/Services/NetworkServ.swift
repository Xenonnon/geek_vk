//
//  NetworkServ.swift
//  Vk
//
//  Created by Евгений Дербенев on 1/17/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {

    let vAPI = MySession.shared.vAPI
    private static let baseUrl = "https://api.vk.com"
    
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
    
    func getUserGroups(completion: @escaping ([Group]) -> Void) {
        //let host = "https://api.vk.com"
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token": MySession.shared.token!,
            "v": vAPI,
            "extended": "1"
        ]
        AF.request(NetworkService.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let groupJSONs = json["response"]["items"].arrayValue
                    let groups = groupJSONs.compactMap { Group($0) }
                    completion(groups)
                case .failure(let error):
                    print(error)
                }
            }
//            AF.request(host+path,
//                       method: .get,
//                       parameters: parameters).responseJSON { (json) in
//                            print(json)
//                       }
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
