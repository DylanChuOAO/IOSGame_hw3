//
//  ResultPage.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/11.
//

import SwiftUI

struct ResultPage: View {
    @State private var playerName = ""
    @State private var playerDateStr = ""
    @State var playerAnswered: Int
    @State var IsFinish: Bool
    @State var playerTime: Double
    @State var playerDate: Date?
    @State private var GOHighScorePage = false
    
    let dateFormatter = DateFormatter()
    var HighScoreData: HighScoreData
    var body: some View {
        VStack{
            Form{
                Section(
                    header: Text("Write Your Name")
                        .font(.custom("Futura-bold", size: 25))
                        .padding(.horizontal)
                ){
                    TextField("Your Name",text: $playerName)
                        .font(.custom("Futura-bold", size: 25))
                        .foregroundColor(.primary)
                }
                Section(
                    header: Text("How much you got?")
                        .font(.custom("Futura-bold", size: 25))
                        .padding(.horizontal)
                ){
                    Text(String(playerAnswered))
                        .font(.custom("Futura-bold", size: 25))
                        .foregroundColor(Color.black)
                }
                Section(
                    header: Text("Do you Finished?")
                        .font(.custom("Futura-bold", size: 25))
                        .padding(.horizontal)
                ){
                    if IsFinish == true{
                        Text("Yes !!")
                            .font(.custom("Futura-bold", size: 25))
                            .foregroundColor(Color.black)
                    }else{//IsFinish == false
                        Text("No !?")
                            .font(.custom("Futura-bold", size: 25))
                            .foregroundColor(Color.black)
                    }
                }
                Section(
                    header: Text("Time You Used")
                        .font(.custom("Futura-bold", size: 25))
                        .padding(.horizontal)
                ) {
                    Text("\(playerTime, specifier: "%.1f") sec")
                        .font(.custom("Futura-bold", size: 25))
                        .foregroundColor(Color.black)
                }
                Section(
                    header: Text("Record Date")
                        .font(.custom("Futura-bold", size: 25))
                        .padding(.horizontal)
                ) {
                    Text(playerDateStr)
                        .font(.custom("Futura-bold", size: 25))
                        .foregroundColor(Color.black)
                }
            }.foregroundColor(.accentColor)
            .padding(.all)
            
            Button(action: {
                if IsFinish == true {
                    let record = Record(PlayerName: playerName, PlayerTime: Int(playerTime), userDateString: playerDateStr, userAnsweredNum: 11, userFinished: IsFinish)
                    self.HighScoreData.record.insert(record, at: 0)
                } else {
                    let record = Record(PlayerName: playerName, PlayerTime: Int(playerTime), userDateString: playerDateStr, userAnsweredNum: playerAnswered, userFinished: IsFinish)
                    self.HighScoreData.record.insert(record, at: 0)
                }
                //resultIntoLB = true
                self.GOHighScorePage = true
            }, label: {
                Text("Save Data")
                    .font(.custom("Futura-bold", size: 35))
                    .frame(width: 210)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, style: StrokeStyle(lineWidth: 2)))
            })
            .padding()
        }
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            dateFormatter.dateFormat = "y/ MM/ d"
            playerDateStr = dateFormatter.string(from: playerDate!)
            if(playerAnswered == 11) {
                IsFinish = true
            }else {
                IsFinish = false
            }
            print(Int(playerTime))
            print(playerDateStr)
            print(IsFinish)
        }.fullScreenCover(isPresented: $GOHighScorePage, content: {
            HighScorePage()
        })
    }
}

struct ResultPage_Previews: PreviewProvider {
    static var previews: some View {
        ResultPage(playerAnswered: 10, IsFinish: true, playerTime: 10, playerDate: Date(), HighScoreData: HighScoreData())
    }
}
