//
//  HighScorePage.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/8.
//

import SwiftUI

struct HighScorePage: View {
    @ObservedObject var highScoreData = HighScoreData()
    @State private var BackToContentView = false
    var body: some View {
            VStack{
                Text("📍High Score📍")
                    .font(.custom("Futura-bold", size: 40))
                    .foregroundColor(.blue)
                    .padding(.top, 40.0)
                List{
                    ScrollView(.horizontal){
                        HStack{
                            VStack{
                                Text("Rank").padding(.bottom)
                                ForEach(0 ..< highScoreData.record.count){ (i) in
                                    Text(String(i + 1))
                                        .padding(.bottom)
                                }
                            }
                            Spacer()
                            VStack{
                                Text("Player").padding(.bottom)
                                ForEach(highScoreData.record){ (i) in
                                    if i.PlayerName == ""{
                                        Text("Unknown").padding(.bottom)
                                    } else {
                                        Text(i.PlayerName).padding(.bottom)
                                    }
                                }
                            }
                            Spacer()
                            VStack{
                                Text("Answered")
                                    .padding(.bottom)
                                ForEach(highScoreData.record){ (i) in
                                    Text(String(i.userAnsweredNum) + "  /  10")
                                        .padding(.bottom)
                                }
                            }
                            Spacer()
                            VStack{
                                Text("Finished")
                                    .padding(.bottom)
                                ForEach(highScoreData.record){ (i) in
                                    if i.userFinished == true{
                                        Text("Yes").padding(.bottom)
                                    } else {
                                        Text("No").padding(.bottom)
                                    }
                                }
                            }
                            Spacer()
                            Group{
                                VStack{
                                    Text("Time")
                                        .padding(.bottom)
                                    ForEach(highScoreData.record){ (i) in
                                        Text("\(i.PlayerTime, specifier: "%.1f")")
                                            .padding(.bottom)
                                    }
                                }
                                VStack{
                                    Text("Date")
                                        .padding(.bottom)
                                    ForEach(highScoreData.record){ (i) in
                                        Text(i.userDateString)
                                            .padding(.bottom)
                                    }
                                }
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.all)
                    .font(.custom("Futura-bold", size:20))
                    .background(Color(red: 47/255, green: 79/255, blue: 79/255))
                    .foregroundColor(.white)
                    Button(action: {BackToContentView = true}, label: {
                        Text("Back to Menu")
                            .font(.custom("Futura-bold", size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 255/255, green: 20/255, blue: 147/255))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(red: 255/255, green: 20/255, blue: 147/255), style: StrokeStyle(lineWidth: 2)))
                    })
                }
            }
        .background(Color.orange)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $BackToContentView, content: {
            ContentView()
        })
    }
}
struct HighScorePage_Previews: PreviewProvider {
    static var previews: some View {
        HighScorePage()
    }
}
