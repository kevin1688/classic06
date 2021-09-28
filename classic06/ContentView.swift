//
//  ContentView.swift
//  classic06
//
//  Created by kai wen chen on 2021/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var number = Date()
    @State var timeText = "0"
    @State var MyDegrees:Double = 0 //秒
    @State var MyDegrees_m:Double = 0 //分
    @State var MyDegrees_h:Double = 0 //時
    
    @State var onOff = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //計時器
    
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                Rectangle()//時針
                    .frame(width: 6, height: 30, alignment: .center)
                    .rotationEffect(Angle.degrees(MyDegrees_h),anchor: .top)
                    .onReceive(timer){ input in
                        number = input
                        let dataformate = DateFormatter()
                        dataformate.dateFormat = "HH" //YYYY-MM-dd-HH-mm-ss 年-月-天-小時-分-秒
                        timeText = dataformate.string(from: input)
                        
                        let dec = Double(timeText)
                        
                        MyDegrees_h = dec! * 6
                    }
                Rectangle() //分針
                    .frame(width: 5, height: 60, alignment: .center)
                    .rotationEffect(Angle.degrees(MyDegrees_m),anchor: .top)
                    .onReceive(timer){ input in
                        number = input
                        let dataformate = DateFormatter()
                        dataformate.dateFormat = "mm" //YYYY-MM-dd-HH-mm-ss 年-月-天-小時-分-秒
                        timeText = dataformate.string(from: input)
                        
                        let dec = Double(timeText)
                        
                        MyDegrees_m = dec! * 6
                    }
                Rectangle() //秒針
                    .frame(width: 2, height: 50, alignment: .center)
                    .rotationEffect(Angle.degrees(MyDegrees),anchor: .top)
                    .onReceive(timer){ input in
                        number = input
                        let dataformate = DateFormatter()
                        dataformate.dateFormat = "ss" //YYYY-MM-dd-HH-mm-ss 年-月-天-小時-分-秒
                        timeText = dataformate.string(from: input)
                        
                        let dec = Double(timeText)
                        
                        withAnimation(.easeInOut(duration: 1.0)) {
                            MyDegrees = dec! * 6
                        }
                        
                    }
                    .foregroundColor(Color.red)
                    //.animation(.easeIn(duration: 1))
            }
            
            Rectangle()
                .frame(width: onOff ? 100 : 50 , height: onOff ? 100 : 50, alignment: .center)
                .foregroundColor(Color.red)
                .padding(.bottom,30)
                .animation(.default)
            
            Rectangle()
                .frame(width: onOff ? 50 : 100 , height: onOff ? 50 : 100, alignment: .center)
                .foregroundColor(Color.red)
                .padding(.bottom,30)
                
            Button {
                onOff.toggle()
            } label: {
                Text("縮放")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//=====兩種傳遞值的做法
//第一種

struct OldView: View {
    @ObservedObject var age = Age() //實際創立一個新的Age資料結構的物件
    
    var body: some View{
        VStack {
            Text("OldView")
            Text("Age:\(age.number)")
            
            Button(action: {
                //age.number += 1
                age.number = age.number + 1
            }, label: {
                Text("age + 1")
            })
        }
    }
    
}

struct NewView: View {
    @StateObject var age = Age()
    
    var body: some View{
        Text("NewView")
        Text("Age:\(age.number)")
        
        Button(action: {
            age.number = age.number + 1
        }, label: {
            Text("age + 1")
        })
    }
    
}
