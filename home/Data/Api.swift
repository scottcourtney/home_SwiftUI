//
//  Api.swift
//  home
//
//  Created by Scott Courtney on 12/27/22.
//

import Foundation
import Alamofire

class Api : ObservableObject{
    @Published var users: User?
    
    func readData(completion:@escaping (User) -> ()) {
        let params: Parameters = [
            "collection": COLLECTION,
            "database": DATABASE,
            "dataSource": DATASOURCE,
            "filter": [
                "user_id": "CH0FuxM5sBMOtRhlGbXCa6dTPZz1"
            ]
        ]
 
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "email": EMAIL,
            "password": PASSWORD
        ]
        
        AF.request(API_URL + "/findOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let userData):
                do {
                    let usersData = try! JSONDecoder().decode(User.self, from: userData)
                    
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
    
    // TODO:
    // ADD ROOM
    
    func addRoom() {
        
        let params: Parameters = [
            "collection": COLLECTION,
            "database": DATABASE,
            "dataSource": DATASOURCE,
            "filter": [
                "user_id": "CH0FuxM5sBMOtRhlGbXCa6dTPZz1",
                "house.house_id": ["$oid":"63925daed836609d85d5da65"]
            ],
            "update": [
                    "$push": [ "house.$.interior.Rooms":
                                [
                                    "room_id": ["$oid":"73925daed836609d85d5da22"],
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
            "email": EMAIL,
            "password": PASSWORD
        ]
        
        AF.request(API_URL + "/updateOne", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print(response)
    
            }
    }
    
    // ADD HOUSE
    // READ DATA
    // DELETE DATA
    // UPDATE DATA
    // CREATE BLANK DOC
    // DELETE ROOM
    // DELETE HOUSE
}
