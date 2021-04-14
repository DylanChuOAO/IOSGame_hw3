//
//  Timer.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/12.
//

import Foundation

class MyTimer: ObservableObject {
    private var freq: Double = 0.01
    private var timer: Timer?
    private var startDate: Date?
    @Published var secondsElapsed:Double = 0
    func start(){
        secondsElapsed = 0
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: freq, repeats: true){
            timer in self.secondsElapsed += self.freq
        }
    }
    func stop(){
        timer?.invalidate()
        timer = nil
    }
    func Continue(){
        timer = Timer.scheduledTimer(withTimeInterval: freq, repeats: true){
            timer in self.secondsElapsed += self.freq
        }
    }
    func getDate() -> Date {
        return startDate!
    }
}
