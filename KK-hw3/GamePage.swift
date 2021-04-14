//
//  GamePage.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/8.
//

import SwiftUI
import AVFoundation

struct GamePage: View {
    @State private var KKColor = Color(red: 47/255, green: 79/255, blue: 79/255)
    @State private var nowIndex: Int = 0
    @State private var nOffset = [CGSize](repeating: CGSize.zero, count: 7)
    @State private var newPosition = [CGSize](repeating: CGSize.zero, count: 7)
    @State private var ansTrue = [Bool](repeating: false, count: 7)
    @State private var cirFrame = [CGRect](repeating: CGRect.zero, count: 7)
    @State private var userAnswered: Int = 0
    @State private var gameFinish = false
    @State private var showResultPage = false
    @StateObject private var Timer = MyTimer()
    @State private var timeMAX: Double = 120
    @State private var timerPause = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    if(timeMAX - Timer.secondsElapsed >= 0){
                        ProgressView(value: (timeMAX - Timer.secondsElapsed)/timeMAX)
                            .progressViewStyle(GreenBarStyle())
                            .frame(width:250)
                        
                    Text("\(timeMAX - Timer.secondsElapsed, specifier: "%0.f")")
                        .font(.custom("Nagurigaki-Crayon", size:40))
                        .foregroundColor(.black)
                        .frame(width:60)
                        .padding(.horizontal)
                    }
                    else{
                        ProgressView(value: 0)
                            .progressViewStyle(GreenBarStyle())
                            .frame(width:250)
                        Text("0")
                            .font(.custom("Nagurigaki-Crayon", size:40))
                            .foregroundColor(.black)
                            .frame(width:60)
                            .padding(.horizontal)
                            .onAppear {//時間結束 跳到結果頁面
                                Timer.stop()
                                showResultPage = true
                            }
                    }
                    if timerPause == false{
                        Button(action: {
                            Timer.stop()
                            timerPause = true
                        }, label:{
                            Image(systemName: "pause.fill")
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                                .foregroundColor(.black)
                        })
                    }
                    else{
                        Button(action: {
                            Timer.Continue()
                            timerPause = false
                        }, label:{
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                                .foregroundColor(.black)
                        })
                    }
                }.padding()
                //KK
                VStack{
                    Text("KK")
                        .font(.custom("Nagurigaki-Crayon", size: 60))
                        .foregroundColor(KKColor)
                    Button(action: {
                        playSound(char: vocArray[nowIndex].last!.eng)
                    }, label: {
                        Image(vocArray[nowIndex].last!.eng)
                            .resizable()
                            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .scaledToFill()
                            .padding()
                            .border(Color.black, width: 5)
                    })
                    Text("Click the picture to listen")
                        .font(.custom("Futura-bold", size: 15))
                }
                Spacer()
                VStack{
                    if vocArray[nowIndex].count == 5{
                        HStack{
                            ForEach(0 ..< 4){ index in
                                if(index < vocArray[nowIndex].count){
                                    Text(vocArray[nowIndex][index].KK)
                                        .foregroundColor(.black)
                                        .font(.custom("Futura-bold", size: 40))
                                        .frame(width: 35, height: 35)
                                        .padding()
                                        .cornerRadius(100)
                                        .offset(nOffset[index])
                                        .gesture(
                                            DragGesture()
                                                .onChanged({value in
                                                    if(ansTrue[index] == false){
                                                        nOffset[index].width = newPosition[index].width + value.translation.width
                                                        nOffset[index].height = newPosition[index].height + value.translation.height
                                                        
                                                    }
                                                }).onEnded({ value in
                                                    newPosition[index] = nOffset[index]
                                                    let mIndex = vocArray[nowIndex][index].index
                                                    let mCGRect = vocArray[nowIndex][index].vCGRect
                                                    if (checkAnswer(mIndex: mIndex, mCGRect: mCGRect, mNewPosition: newPosition[index])){
                                                        if(ansTrue[index] == false){
                                                            nOffset[index].width = cirFrame[mIndex].minX - mCGRect.minX + 5
                                                            nOffset[index].height = cirFrame[mIndex].minY - mCGRect.minY + 5
                                                            ansTrue[index] = true
                                                            nextQuestion()
                                                        }
                                                    }else{
                                                        //回去原本位置
                                                        nOffset[index] = CGSize.zero
                                                        newPosition[index] = CGSize.zero
                                                    }
                                                })
                                        )
                                        .overlay(
                                            GeometryReader(content: { geometry in
                                            Color.clear
                                                .onAppear(perform: {
                                                    vocArray[nowIndex][index].vCGRect = geometry.frame(in: .global)
                                                })
                                            })
                                        )
                                }
                            }
                        }
                        HStack{
                            ForEach(0 ..< 4){ index in
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 3)
                                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal, 2)
                                    .overlay(
                                        GeometryReader(content:{geometry in
                                            Color.clear
                                                .onAppear(perform: {
                                                    cirFrame[index] = geometry.frame(in: .global)
                                                })
                                        })
                                    )
                            }
                        }
                    }
                    else if vocArray[nowIndex].count == 6{
                        HStack{
                            ForEach(0 ..< 5){ index in
                                if(index < vocArray[nowIndex].count){
                                    Text(vocArray[nowIndex][index].KK)
                                        .foregroundColor(.black)
                                        .font(.custom("Futura-bold", size: 40))
                                        .frame(width: 35, height: 35)
                                        .padding()
                                        .cornerRadius(100)
                                        .offset(nOffset[index])
                                        .gesture(
                                            DragGesture()
                                                .onChanged({ value in
                                                    if (ansTrue[index] == false){
                                                        nOffset[index].width = newPosition[index].width + value.translation.width
                                                            nOffset[index].height = newPosition[index].height + value.translation.height
                                                        }
                                                    })
                                                .onEnded({value in
                                                    newPosition[index] = nOffset[index]
                                                    let mIndex = vocArray[nowIndex][index].index
                                                    let mCGRect = vocArray[nowIndex][index].vCGRect
                                                    if (checkAnswer(mIndex: mIndex, mCGRect: mCGRect, mNewPosition: newPosition[index])){
                                                        if (ansTrue[index] == false){
                                                            nOffset[index].width = cirFrame[mIndex].minX - mCGRect.minX + 5
                                                            nOffset[index].height = cirFrame[mIndex].minY - mCGRect.minY + 5
                                                            ansTrue[index] = true
                                                            playSound(char: vocArray[nowIndex][index].KK)
                                                            nextQuestion()
                                                        }
                                                    }else{
                                                        //回去原本位置
                                                        nOffset[index] = CGSize.zero
                                                        newPosition[index] = CGSize.zero
                                                    }
                                                })
                                        ).overlay(
                                            GeometryReader(content:{ geometry in
                                                Color.clear
                                                    .onAppear(perform: {
                                                        vocArray[nowIndex][index].vCGRect = geometry.frame(in: .global)
                                                    })
                                                
                                            })
                                        )
                                }
                            }
                        }
                        HStack{
                            ForEach(0 ..< 5){ index in
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 3)
                                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(
                                        GeometryReader(content:{geometry in
                                            Color.clear
                                                .onAppear(perform: {
                                                    cirFrame[index] = geometry.frame(in: .global)
                                                })
                                        })
                                    )
                            }
                        }
                    }
                    else if vocArray[nowIndex].count == 7{
                        HStack{
                            ForEach(0 ..< 6){ index in
                                if(index < vocArray[nowIndex].count){
                                    Text(vocArray[nowIndex][index].KK)
                                        .foregroundColor(.black)
                                        .font(.custom("Futura-bold", size: 35))
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .cornerRadius(100)
                                        .offset(nOffset[index])
                                        .gesture(
                                            DragGesture()
                                                .onChanged({ value in
                                                    if (ansTrue[index] == false){
                                                        nOffset[index].width = newPosition[index].width + value.translation.width
                                                            nOffset[index].height = newPosition[index].height + value.translation.height
                                                        }
                                                    })
                                                .onEnded({value in
                                                    newPosition[index] = nOffset[index]
                                                    let mIndex = vocArray[nowIndex][index].index
                                                    let mCGRect = vocArray[nowIndex][index].vCGRect
                                                    if (checkAnswer(mIndex: mIndex, mCGRect: mCGRect, mNewPosition: newPosition[index])){
                                                        if (ansTrue[index] == false){
                                                            nOffset[index].width = cirFrame[mIndex].minX - mCGRect.minX + 2
                                                            nOffset[index].height = cirFrame[mIndex].minY - mCGRect.minY + 2
                                                            ansTrue[index] = true
                                                            playSound(char: vocArray[nowIndex][index].KK)
                                                            nextQuestion()
                                                        }
                                                    }else{
                                                        //回去原本位置
                                                        nOffset[index] = CGSize.zero
                                                        newPosition[index] = CGSize.zero
                                                    }
                                                })
                                        ).overlay(
                                            GeometryReader(content:{ geometry in
                                                Color.clear
                                                    .onAppear(perform: {
                                                        vocArray[nowIndex][index].vCGRect = geometry.frame(in: .global)
                                                    })
                                                
                                            })
                                        )
                                }
                            }
                        }
                        HStack{
                            ForEach(0 ..< 6){ index in
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 3)
                                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(
                                        GeometryReader(content:{geometry in
                                            Color.clear
                                                .onAppear(perform: {
                                                    cirFrame[index] = geometry.frame(in: .global)
                                                })
                                        })
                                    )
                            }
                        }
                    }
                    else if vocArray[nowIndex].count == 8{
                        HStack{
                            ForEach(0 ..< 7){ index in
                                if(index < vocArray[nowIndex].count){
                                    Text(vocArray[nowIndex][index].KK)
                                        .foregroundColor(.black)
                                        .font(.custom("Futura-bold", size: 25))
                                        .frame(width: 20, height: 20)
                                        .padding()
                                        .cornerRadius(100)
                                        .offset(nOffset[index])
                                        .gesture(
                                            DragGesture()
                                                .onChanged({value in
                                                    if(ansTrue[index] == false){
                                                        nOffset[index].width = newPosition[index].width + value.translation.width
                                                        nOffset[index].height = newPosition[index].height + value.translation.height
                                                        
                                                    }
                                                }).onEnded({ value in
                                                    newPosition[index] = nOffset[index]
                                                    let mIndex = vocArray[nowIndex][index].index
                                                    let mCGRect = vocArray[nowIndex][index].vCGRect
                                                    if (checkAnswer(mIndex: mIndex, mCGRect: mCGRect, mNewPosition: newPosition[index])){
                                                        if(ansTrue[index] == false){
                                                            nOffset[index].width = cirFrame[mIndex].minX - mCGRect.minX + 1
                                                            nOffset[index].height = cirFrame[mIndex].minY - mCGRect.minY + 1
                                                            ansTrue[index] = true
                                                            playSound(char: vocArray[nowIndex][index].KK)
                                                            nextQuestion()
                                                        }
                                                    }else{
                                                        //回去原本位置
                                                        nOffset[index] = CGSize.zero
                                                        newPosition[index] = CGSize.zero
                                                    }
                                                })
                                        )
                                        .overlay(
                                            GeometryReader(content: { geometry in
                                            Color.clear
                                                .onAppear(perform: {
                                                    vocArray[nowIndex][index].vCGRect = geometry.frame(in: .global)
                                                })
                                            })
                                        )
                                }
                            }
                        }
                        HStack{
                            ForEach(0 ..< 7){ index in
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 3)
                                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(
                                        GeometryReader(content:{geometry in
                                            Color.clear
                                                .onAppear(perform: {
                                                    cirFrame[index] = geometry.frame(in: .global)
                                                })
                                        })
                                    )
                            }
                        }
                    }
                }.fullScreenCover(isPresented: $showResultPage, content: {
                    ResultPage(playerAnswered: userAnswered, IsFinish: gameFinish, playerTime: Timer.secondsElapsed, playerDate: Timer.getDate(), HighScoreData: HighScoreData())
                })
                Spacer()
            }.onAppear{
                playSound(char: vocArray[0].last!.eng)
                Timer.start()
                print(vocArray[0].count - 1)
            }
            .background(Image("konoha")
                .opacity(0.5)
                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all))
        }
    }
    //給我講話！！
    func playSound(char: String) -> Void {
        let utterance =  AVSpeechUtterance(string: char)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    //檢查答案！！
    func checkAnswer(mIndex: Int, mCGRect: CGRect, mNewPosition: CGSize) -> Bool{
        if(mCGRect.minX + mNewPosition.width >= cirFrame[mIndex].minX - 30 &&
            mCGRect.maxX + mNewPosition.width <= cirFrame[mIndex].maxX + 30 &&
            mCGRect.minY + mNewPosition.height >= cirFrame[mIndex].minY - 30 &&
            mCGRect.maxY + mNewPosition.height <= cirFrame[mIndex].maxY + 30){
            return true
        }
        print(mIndex, mCGRect, mNewPosition, cirFrame[mIndex])
        return false
    }
    //下一題！！
    func nextQuestion() -> Void {
        if ansTrue[0...vocArray[nowIndex].count - 2].contains(where: { $0 == false }){
            return //有錯 退回
        }else{ //OK 下一題
            var charXY = [CGRect]()
            for i in 0 ..< vocArray[nowIndex].count - 1{
                charXY.append(vocArray[nowIndex][i].vCGRect) //題目＋1
            }
            //答對次數
            userAnswered += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                playSound(char: vocArray[nowIndex].last!.eng)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    if nowIndex < vocArray.count - 1{
                        nowIndex += 1
                        print(nowIndex)
                        if charXY.count == vocArray[nowIndex].count - 1{
                            for i in 0 ..< vocArray[nowIndex].count - 1{
                                vocArray[nowIndex][i].vCGRect = charXY[i]
                            }
                        }
                        nOffset = [CGSize](repeating: CGSize.zero, count: 7)
                        newPosition = [CGSize](repeating: CGSize.zero, count: 7)
                        ansTrue = [Bool](repeating: false, count: 7)
                        playSound(char: vocArray[nowIndex].last!.eng)
                    }else{
                        gameFinish = true
                        showResultPage = true
                    }
                }
            }
        }
    }
}

struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        GamePage()
    }
}
struct GreenBarStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .accentColor(Color(red: 255/255, green: 20/255, blue: 147/255))
            .scaleEffect(x: 1, y: 3, anchor: .center)
            .shadow(color: Color(red: 255/255, green: 174/255, blue: 185/255),
                    radius: 4.0, x: 1.0, y: 3.0)
    }
}
