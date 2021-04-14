//
//  HighScoreData.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/13.
//

import Foundation

struct Record: Identifiable, Codable  {
    var id = UUID()
    var PlayerName: String
    var PlayerTime: Int
    var userDateString: String
    var userAnsweredNum: Int
    var userFinished: Bool
}


class HighScoreData: ObservableObject {
    @Published var record = [Record](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(record) {
                UserDefaults.standard.set(data, forKey: "records")
            }
        }
    }
    init(){
        if let data = UserDefaults.standard.data(forKey: "records") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Record].self,from: data) {
                record = decodedData
            }
        }
    }
}
        
        
