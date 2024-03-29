//
//  ContentView.swift
//  JSON
//
//  Created by Swope, Thomas on 12/12/22.
//

import SwiftUI
import struct Kingfisher.KFImage


struct ContentView: View {
    
    @StateObject var data = FetchData()
    
    var body: some View {
        
        VStack {
            //update so that you decode source name, author, description, url, urlToImage, and content
            // update display so that you can see the author and source name as well as the title
            ScrollView{
                ForEach(data.response.articles) { a in
                    VStack{
                        Text("\(a.title)")
                            .padding()
                    }
                }
            }
            Spacer()
        }.task{
            await data.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
