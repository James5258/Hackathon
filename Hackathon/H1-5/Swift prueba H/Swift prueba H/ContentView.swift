//
//  ContentView.swift
//  Swift prueba H
//
//  Created by iOS Lab on 29/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color("beish2"))
           
            VStack{
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color("beish"))
                    .frame(width: 389, height: 173)
                    .cornerRadius(20)
                .position(x:196,y:29)
                
                    ZStack{
                        Image("ojj")
                            .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                            .frame(width: 85.0, height: 85.0)
                            .position(x:60,y:-350)
                        HStack{ 
                            
                        }
                        
                    Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(Color("beish"))
                            .frame(width: 389, height: 90)
                            .cornerRadius(20)
                            .position(x:196,y:360)

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
