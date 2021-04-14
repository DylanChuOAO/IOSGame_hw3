//
//  ContentView.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/8.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showHS = false
    @State private var showAnti = false
    @State private var musicImg = "play.fill"
    @State var looper: AVPlayerLooper?
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("KK音標")
                        .font(.custom("Nagurigaki-Crayon",size:60))
                        .foregroundColor(Color(red: 30/255, green: 144/255, blue: 255/255, opacity: 1.0))
                    + Text(" 競技場")
                        .font(.custom("Nagurigaki-Crayon",size:60))
                        .foregroundColor(Color(red: 255/255, green: 99/255, blue: 71/255))
                }.multilineTextAlignment(.center)
                .padding(.top, 0.0)
                VStack{
                    Text("小時候學的KK音標還會嗎？？")
                        .font(.custom("Futura-bold", size: 20))
                        .foregroundColor(Color(red: 154/255, green: 50/255, blue: 205/255))
                        .padding()
                }
                Image("dogBG")
                    .resizable()
                Spacer()
                //start
                Button(action:{
                    showAnti = true
                    print(showAnti)
                }){
                    Text("Play")
                        .font(.custom("Futura-bold", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0/255, green: 0/255, blue: 205/255))
                        .multilineTextAlignment(.center)
                        .frame(width: 100.0)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(red: 0/255, green: 0/255, blue: 205/255), style: StrokeStyle(lineWidth: 2)))
                }.padding()
                .fullScreenCover(isPresented: $showAnti, content: {
                    AntiPage()
                })
                
                Button(action: {showHS = true}, label: {
                    Text("High Score")
                        .font(.custom("Futura-bold", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 255/255, green: 222/255, blue: 173/255))
                        .multilineTextAlignment(.center)
                        .frame(width: 220.0)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(red: 255/255, green: 222/255, blue: 173/255), style: StrokeStyle(lineWidth: 2)))
                })
                .padding()
                .sheet(isPresented: $showHS, content: {
                    HighScorePage()
                })
                Link(destination: URL(string: "https://zh.wikipedia.org/wiki/KK音標".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!, label: {
                    Text("What's KK?")
                        .font(.custom("Futura-bold", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 255/255, green: 20/255, blue: 147/255))
                        .multilineTextAlignment(.center)
                        .frame(width: 230.0)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(red: 255/255, green: 20/255, blue: 147/255), style: StrokeStyle(lineWidth: 2)))
                })
                .padding()
            }
            .navigationBarItems(
                trailing: Button(action:{
                if musicPlayer.timeControlStatus == .playing {
                    musicPlayer.pause()
                    musicImg = "play.slash.fill"
                } else {
                    musicPlayer.play()
                    musicImg = "play.fill"
                }
            }){
                Text("Music")
                    .font(.custom("Nagurigaki-Crayon", size: 60))
                    .foregroundColor(.white)
                Image(systemName: musicImg)
                    .foregroundColor(.white)
                    .imageScale(.large)
            })
            .background(Image("night")
                .resizable()
                .opacity(0.6)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: 800, height: 1200, alignment: .center))
            .onAppear{
                vocArray.shuffle()
                for i in 0 ..< vocArray.count{
                    let last = vocArray[i].count - 2
                    vocArray[i][0...last].shuffle()
                }
                let fileURL = Bundle.main.url(forResource: "BGmusic", withExtension: "mp4")!
                let item = AVPlayerItem(url: fileURL)
                //BG music
                if musicPlayer.timeControlStatus == .playing || firstIntoAPP {
                    musicImg = "play.full"
                }else{
                    musicImg = "play.slash.fill"
                }
                if firstIntoAPP == true{
                    self.looper = AVPlayerLooper(player: musicPlayer, templateItem: item)
                    musicPlayer.volume = 0.1
                    musicPlayer.play()
                    firstIntoAPP = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
