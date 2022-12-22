//
//  ContentView.swift
//  JSON
//
//  Created by Swope, Thomas on 12/12/22.
//

import SwiftUI
import struct Kingfisher.KFImage
import SFSafeSymbols


struct ContentView: View {
    
    @StateObject var data = FetchData()
    
    var body: some View {
        
        VStack {
            //update so that you decode source name, author, description, url, urlToImage, and content
            // update display so that you can see the author and source name as well as the title
            NavigationView {
                ScrollView{
                    ForEach(data.response.articles) { a in
                        NavigationLink(destination: {
                            SwiftUIWebView(url: URL(string: a.url))
                        }, label: {
                            VStack{
                                KFImage(URL(string: a.urlToImage ?? " "))
                                    .placeholder{
                                        Image(systemName: SFSymbol._00CircleFill.rawValue)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Text("\(a.title)")
                                    .padding()
                            }
                        })
                        
                        
                    }.navigationTitle("Sports")
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
