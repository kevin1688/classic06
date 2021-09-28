//
//  DemoTransData.swift
//  classic06
//
//  Created by kai wen chen on 2021/9/28.
//

import SwiftUI

struct DemoTransData: View {
    
    @StateObject var myData = Age()
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink {
                    other()
                } label: {
                    Text("到另一個View")
                }
                .padding(.bottom,40)
                
                Button {
                    myData.number += 1
                } label: {
                    Text("變動年紀加一歲")
                }

            }
            
        }.environmentObject(myData) //傳遞資料時添加對象物件即可
    }
}

struct DemoTransData_Previews: PreviewProvider {
    static var previews: some View {
        DemoTransData()
    }
}

struct other: View {
    
    @EnvironmentObject var myData:Age
    
    var body: some View {
        Text("\(myData.number)歲")
    }
}


struct other1: View {
    
    @EnvironmentObject var myData:Age
    
    var body: some View {
        VStack {
            Text("\(myData.number)歲")
            Text("\(myData.name)歲")
            Text("\(myData.name1)歲")
            Text("\(myData.name2)歲")
            
        }
    }
}
