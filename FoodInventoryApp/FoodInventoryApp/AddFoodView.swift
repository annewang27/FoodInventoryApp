//
//  AddFoodView.swift
//  FoodInventoryApp
//
//  Created by Anne Wang on 2020-04-25.
//  Copyright © 2020 Anne Wang. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct AddFoodView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var category: String
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var starred: Bool = false
    @State private var newFood = [String: String]()
    @State private var editing = false
    @State private var setName = false
    @State private var setQuantity = false
    
    init(Category: String, Editing: Bool, Name: String = "", Quantity: String = "", Starred: Bool = false) {
        category = Category
        name = Name
        quantity = Quantity
        starred = Starred
        editing = Editing
    }
    
    func addFood() {
        let db = Firestore.firestore()
        newFood["quantity"] = quantity
        newFood["starred"] = "false"
        if starred {
            newFood["starred"] = "true"
        }
        
        db.collection(category).document(name).setData(newFood) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        VStack {
            Text("Add to Inventory")
                .font(.title)
                .foregroundColor(ColorManager.darkGreenHeader)
                .padding()
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("I bought ...")
                    .font(.headline)
                TextField("Sustenance", text: $name, onCommit:
                            {
                                setName = true
                            })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Quantity ...")
                    .font(.headline)
                TextField("A lot", text: $quantity, onCommit:
                            {
                                setQuantity = true
                            })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Spacer()
            
            Button("Done", action: { addFood() })
                .disabled(!setQuantity || !setName)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(Category: "fridge", Editing: false)
    }
}
