//
//  TimerView.swift
//  Shared
//
//  Created by Kevin Stechler on 3/24/22.
//
import SwiftUI

struct TimerView: View {
    @State private var currentDate = Date()
    @State private var timeInterval = 0
    @ObservedObject var timerService = TimerService()
    
    var body: some View {
        VStack {
            HStack {
                //Button("Start") {print("hello")}.buttonStyle(.bordered)
                Button("10s") {
                    timerService.setTime(10)
                    timerService.startTimer()
                }.buttonStyle(.bordered)
                Button("30s") {
                    timerService.setTime(30)
                    timerService.startTimer()
                }.buttonStyle(.bordered)
                Button("1m") {
                    timerService.setTime(60)
                    timerService.startTimer()
                }.buttonStyle(.bordered)
                Button("Stop") {
                    timerService.setTime(0)
                    timerService.stopTimer()
                }.buttonStyle(.bordered)
            }
            ZStack {
                Text(timerService.hasStarted ? "\(Int(timerService.timeRemaining ))" : "Select a time").fontWeight(.heavy)
                .onReceive(timerService.timer) { _ in
                    timerService.driveTimer()
                }
                ProgressView(value: timerService.timeRemaining, total: timerService.totalTime).progressViewStyle(CustomCircularProgressViewStyle())
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

struct CustomCircularProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let lineWidth = CGFloat(30)
        let circleWidth = CGFloat(250)
        Circle()
            .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: lineWidth))
            .frame(width: circleWidth)
        Circle()
            .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0))
            .stroke(Color.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .rotationEffect(.degrees(90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .frame(width: circleWidth)
    }
}

