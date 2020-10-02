//
//  ContentView.swift
//  FoodInventoryApp
//
//  Created by Anne Wang on 2020-04-23.
//  Copyright © 2020 Anne Wang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showFridge = false
    @State private var showFreezer = false
    @State private var showPantry = false
    
    var body: some View {
        NavigationView {
            VStack{
                Text("I have ...")
                    .font(.system(size: 40, weight: .light))
                    .foregroundColor(.white)
                Divider()
                ScrollView {
                    VStack{
                        HStack{
                            Text("FRIDGE")
                                .font(.title)
                                .foregroundColor(ColorManager.darkGreenHeader)
                                .padding()
                            Spacer()
                            Button(action: { self.showFridge.toggle()})
                                {Image(systemName: showFridge ? "chevron.up" : "chevron.down")
                                .foregroundColor(ColorManager.darkGreenHeader)}
                                .padding()
                        }
                        if showFridge {
                            CategoryView(category: "fridge")
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .padding()
                    
                    VStack{
                        HStack{
                            Text("FREEZER")
                                .font(.title)
                                .foregroundColor(ColorManager.darkGreenHeader)
                                .padding()
                            Spacer()
                            Button(action: { self.showFreezer.toggle()})
                                {Image(systemName: showFreezer ? "chevron.up" : "chevron.down")
                                .foregroundColor(ColorManager.darkGreenHeader)}
                                .padding()
                        }
                        if showFreezer {
                            CategoryView(category: "freezer")
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .padding()
                    
                    VStack{
                        HStack{
                            Text("PANTRY")
                                .font(.title)
                                .foregroundColor(ColorManager.darkGreenHeader)
                                .padding()
                            Spacer()
                            Button(action: { self.showPantry.toggle()})
                                {Image(systemName: showPantry ? "chevron.up" : "chevron.down")
                                .foregroundColor(ColorManager.darkGreenHeader)}
                                .padding()
                        }
                        if showPantry {
                            CategoryView(category: "pantry")
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .padding()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorManager.darkGreenBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
