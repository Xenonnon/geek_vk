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
    
    func getUserFriends(completion: @escaping ([User]) -> Void) {
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": MySession.shared.token,
            "v": vAPI,
            "fields": "photo_100"
        ]
        AF.request(NetworkService.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let friendsJSONList = json["response"]["items"].arrayValue
                    let friends = friendsJSONList.compactMap { User($0) }
                    completion(friends)
                    try? RealmServce.save(items: friends)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void) {
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": MySession.shared.token,
            "v": vAPI,
            "extended": 1,
            "owner_id": "\(userId)"
        ]
        AF.request(NetworkService.baseUrl + path,
                   method: .get,
                   parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let photoJSONs = json["response"]["items"].arrayValue
                    let photos = photoJSONs.compactMap { Photo($0) }
                    completion(photos)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getUserGroups(completion: @escaping ([Group]) -> Void) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token": MySession.shared.token,
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
                    try? RealmServce.save(items: groups)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func searchGroups(by caption: String) {
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "access_token": MySession.shared.token,
            "v": vAPI,
            "q": caption,
            "type": "group"
        ]
        AF.request(NetworkService.baseUrl + path,
                       method: .get,
                       parameters: parameters).responseJSON { response in
                        guard let json = response.value else { return }
                        print(json)
                    }
    }
}
