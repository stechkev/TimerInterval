//
//  TimerService.swift
//  TimerInterval
//
//  Created by Kevin Stechler on 3/24/22.
//
import SwiftUI
import AVFoundation
import Foundation

class TimerService: ObservableObject {
    @Published var timeRemaining = Double()
    @Published var totalTime = Double()
    @Published var hasStarted = false
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setTime(_ seconds: Double) {
        timeRemaining = seconds
        totalTime = seconds
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func driveTimer() {
        if timeRemaining > 1 {
            timeRemaining -= 1
        }
        else if hasStarted {
            timeRemaining = totalTime
            AudioServicesPlaySystemSound(1257)
        }
    }
    
    func startTimer() {
        hasStarted = true
    }
    
    func stopTimer() {
        hasStarted = false
    }

}


