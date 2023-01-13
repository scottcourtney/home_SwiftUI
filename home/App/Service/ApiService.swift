//
//  Api.swift
//  home
//
//  Created by Scott Courtney on 12/27/22.
//

import Foundation
import Alamofire
import SwiftUI

class ApiService : ObservableObject {
    
    @Published var user: User?
    @Published private var _isLoading: Bool = false
    
    func getToken() -> String {
        let data = KeychainService.standard.read(service: "access-token", account: "firebase")!
        let jwtTokenString = String(data: data, encoding: .utf8)!
        return jwtTokenString
    }
    
    // READ DATA
    func getUserData(userId: String, completion: @escaping (User) -> ()) {
        let jwtTokenString = getToken()
        let params: Parameters = [
            "collection": COLLECTION,
            "database": DATABASE,
            "dataSource": DATASOURCE,
            "filter": [
                "userInfo.user_id": userId
            ]
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "jwtTokenString": jwtTokenString
        ]
        
        AF.request(API_URL + "/findOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let userData):
                do {
                    let usersData = try! JSONDecoder().decode(User.self, from: userData)
                    self.user = usersData
                    
                    guard let jsonObject = try JSONSerialization.jsonObject(with: userData) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    let file = "data.json"
                    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let fileURL = dir.appendingPathComponent(file)
                        do {
                            try prettyPrintedJson.write(to: fileURL, atomically: false, encoding: .utf8)
                        }
                        catch {}
                    }
                    
                    DispatchQueue.main.async {
                        completion(usersData)
                    }
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }.resume()
    }
    
    // ADD ROOM
    func addRoom(
        userId: String,
        houseId: String,
        nickname: String,
        completion: @escaping (Bool) -> ()) {
            let jwtTokenString = getToken()
            
            let params: Parameters = [
                "collection": COLLECTION,
                "database": DATABASE,
                "dataSource": DATASOURCE,
                "filter": [
                    "userInfo.user_id": userId,
                    "house.house_id": ["$oid": houseId]
                ],
                
                "update": [
                    "$push": [ "house.$.interior.Rooms":
                                [
                                    "room_id": UUID().uuidString,
                                    "roomType": "bedroom",
                                    "nickname": "Test2 Room",
                                    "Ceiling": [
                                        "paintBrand": "Sherwin Williams",
                                        "paintColor": "White",
                                        "paintFinish": "Satin"
                                    ],
                                    "Walls": [
                                        "paintBrand": "Sherwin Williams",
                                        "paintColor": "Green",
                                        "paintFinish": "Satin"
                                    ],
                                    "Flooring": [
                                        "paintBrand": "Sherwin Williams",
                                        "paintColor": "Cherry",
                                        "paintFinish": "Satin"
                                    ]
                                ]
                             ]
                ]
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "jwtTokenString": jwtTokenString
            ]
            
            AF.request(API_URL + "/updateOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    print(response)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
        }
    
    // ADD HOUSE
    func addHouse(
        userId: String,
        nickname: String,
        completion: @escaping (Bool) -> ()) {
            let jwtTokenString = getToken()
            
            let params: Parameters = [
                "collection": COLLECTION,
                "database": DATABASE,
                "dataSource": DATASOURCE,
                "filter": [
                    "userInfo.user_id": userId,
                ],
                
                "update": [
                    "$push": [ "house":
                                [
                                    "house_id": UUID().uuidString,
                                    "nickname": nickname,
                                    "interior": [
                                        "Rooms":[],
                                        "Appliances": []
                                    ],
                                    "exterior": []
                                ]
                             ]
                ]
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "jwtTokenString": jwtTokenString
            ]
            
            AF.request(API_URL + "/updateOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    print(response)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
        }
    
    // ADD APPLIANCE
    func addAppliance(
        userId: String,
        houseId: String,
        nickname: String,
        brand: String,
        model: String,
        website: String,
        otherInformation: String,
        completion: @escaping (Bool) -> ()) {
            let jwtTokenString = getToken()
            
            let params: Parameters = [
                "collection": COLLECTION,
                "database": DATABASE,
                "dataSource": DATASOURCE,
                "filter": [
                    "userInfo.user_id": userId,
                    "house.house_id": ["$oid": houseId]
                ],
                "update": [
                    "$push": [ "house.$.interior.Appliances":
                                [
                                    "nickname": nickname,
                                    "appliance_id": UUID().uuidString,
                                    "brand": brand,
                                    "model": model,
                                    "website": website,
                                    "other": otherInformation
                                ]
                             ]
                ]
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "jwtTokenString": jwtTokenString
            ]
            
            AF.request(API_URL + "/updateOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    print(response)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
        }
    
    // CREATE BLANK DOC
    func createUser(
        userId: String,
        nickname: String,
        email: String,
        firstName: String,
        lastName: String,
        completion: @escaping (Bool) -> ()) {
            let jwtTokenString = getToken()

            let params: Parameters = [
                "collection": COLLECTION,
                "database": DATABASE,
                "dataSource": DATASOURCE,
                
                "document": [
                    "userInfo": [
                        "user_id": userId,
                        "email": email,
                        "firstName": firstName,
                        "lastName": lastName
                    ],
                    "house": [
                        [
                        "house_id": UUID().uuidString,
                        "nickname": nickname,
                        "interior": [
                            "Rooms":[],
                            "Appliances": [],
                            "Misc": [
                                "lightbulbs": [],
                                "filters": []
                            ]
                        ],
                        "exterior": [
                            "test": "test"
                        ]
                    ]
                    ]
                ]
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "jwtTokenString": jwtTokenString
            ]
            
            AF.request(API_URL + "/insertOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    print(response)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
        }
    
    
    // DELETE DATA
    // UPDATE DATA
    // DELETE ROOM
    // DELETE HOUSE
}