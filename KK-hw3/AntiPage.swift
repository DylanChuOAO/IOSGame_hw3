//
//  AntiPage.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/10.
//

import SwiftUI
import AVFoundation

struct AntiPage: View {
    @State private var showText = "Are you ready?"
    //showText = "Are you ready?" -> "3" -> "2" -> "1"
    @State private var textColor = Color.black
    //textColor = "black" -> "" -> "" -> ""
    @State private var textSize = 50
    @State private var GameViewPage_Start = false
    var body: some View {
        VStack{
            Text(showText)
                .font(.custom("Nagurigaki-Crayon",size:CGFloat(textSize)))
                .foregroundColor(textColor)
                .animation(/*@START_MENU_TOKEN@*/.easeOut/*@END_MENU_TOKEN@*/)
                .scaledToFit()
        }
        .onAppear{
            playSound(char: showText)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                showText = "3"
                textColor = .purple
                textSize = 170
                playSound(char: showText)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    showText = "2"
                    textColor = .pink
                    textSize = 170
                    playSound(char: showText)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        showText = "1"
                        textColor = .orange
                        textSize = 170
                        playSound(char: showText)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                            showText = "Let's GO!!"
                            textColor = .orange
                            textSize = 70
                            playSound(char: showText)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            GameViewPage_Start = true
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .background(Image("konoha")
                        .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: $GameViewPage_Start, content: {
            GamePage()
        })
        
        
    }
    //給我講話！！
    func playSound(char: String) -> Void {
        let utterance =  AVSpeechUtterance(string: char)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct AntiPage_Previews: PreviewProvider {
    static var previews: some View {
        AntiPage()
    }
}
