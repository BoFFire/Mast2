//
//  InstanceExtension.swift
//  Mast
//
//  Created by Shihab Mehboob on 08/11/2019.
//  Copyright © 2019 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit

class InstanceData: Codable {
    var redirect: String
    var clientID: String
    var clientSecret: String
    var authCode: String
    var accessToken: String
    var returnedText: String
    var instanceText: String
    
    init(clientID: String = "", clientSecret: String = "", authCode: String = "", accessToken: String = "", returnedText: String = "", instanceText: String = "", redirect: String = "") {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.authCode = authCode
        self.accessToken = accessToken
        self.returnedText = returnedText
        self.instanceText = instanceText
        self.redirect = redirect
    }
    
    static func getAllInstances() -> [InstanceData] {
        guard let instaceData = UserDefaults.standard.object(forKey: "instances") as? Data, let instances = try? PropertyListDecoder().decode(Array<InstanceData>.self, from: instaceData) else {
            return [InstanceData]()
        }
        return instances
    }
    
    static func getCurrentInstance() -> InstanceData? {
        guard let instanceData = UserDefaults.standard.data(forKey: "currentInstance"), let instance = try? JSONDecoder().decode(InstanceData.self, from: instanceData) else {
            return nil
        }
        return instance
    }
    
    static func setCurrentInstance(instance: InstanceData) {
        guard let instanceData = try? JSONEncoder().encode(instance) else {
           return
        }
        
        UserDefaults.standard.set(instanceData, forKey: "currentInstance")
        GlobalStruct.client.accessToken = instance.accessToken
        
        UserDefaults.standard.set(instance.clientID, forKey: "clientID")
        UserDefaults.standard.set(instance.clientSecret, forKey: "clientSecret")
        UserDefaults.standard.set(instance.authCode, forKey: "authCode")
        UserDefaults.standard.set(instance.accessToken, forKey: "accessToken")
        UserDefaults.standard.set(instance.returnedText, forKey: "returnedText")
        
        GlobalStruct.newClient = Client(baseURL: "")
        GlobalStruct.newInstance = nil
        GlobalStruct.notifications = []
        GlobalStruct.notificationsMentions = []
        GlobalStruct.notificationsDirect = []
        GlobalStruct.currentInstance = instance
    }
    
    static func clearInstances() {
        UserDefaults.standard.setValue(nil, forKey: "instances")
    }
}

extension InstanceData: Equatable {
    static func == (lhs: InstanceData, rhs: InstanceData) -> Bool {
        return lhs.clientID == rhs.clientID && lhs.accessToken == rhs.accessToken
    }
}

