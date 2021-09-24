//
//  ContentView.swift
//  classic06
//
//  Created by kai wen chen on 2021/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var number = Date()
    
    @State var timeText = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //計時器
    
    
    var body: some View {
        VStack{
            OldView()
                .padding(.bottom,20)
            NewView()
            
            Text("value:\(timeText)")
                .onReceive(timer){ input in
                    number = input
                    let dataformate = DateFormatter()
                    dataformate.dateFormat = "ss" //YYYY-MM-dd-HH-mm-ss 年-月-天-小時-分-秒
                    timeText = dataformate.string(from: input)
                    
                    var dec = Int(timeText)
                    
                }
                .padding(.top,30)
            
            Button(action: {
                
            }, label: {
                Text("按鈕")
            })
            .padding(.top,40)
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
