//
//  ItemRow.swift
//  FoodInventoryApp
//
//  Created by Anne Wang on 2020-04-23.
//  Copyright © 2020 Anne Wang. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct ItemRow: View {
    var foodObject: FoodObject
    var category: String = ""
//    @Binding var toDelete: String
    
    @State private var edit = false
    @State private var starred : Bool = false
    @State private var starColor : Color = .gray
    
    init(Food: FoodObject, Category: String) {
        foodObject = Food
        starred = foodObject.starred
//        _toDelete = ToDelete // can't seem to init a binding var in a custom init for now
        category = Category
        
        if foodObject.starred {
            starColor = .yellow
        }
    }
    
    func toggleStarred() {
        starred.toggle()
        if starred {
            starColor = .yellow
        } else {
            starColor = .gray
        }
    }
    
    func deleteItem() {
        let db = Firestore.firestore()
        db.collection(category).document(foodObject.name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    var body: some View {
        HStack {
            Button(action: { toggleStarred() }) {
                Image(systemName: starred ? "star.fill" : "star")
                    .foregroundColor(starColor)
                    .padding()
            }
            
            VStack {
                Text(foodObject.name)
                    .font(.subheadline)
                Text(foodObject.quantity)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
            
            Button(action: { deleteItem() })
                {Image(systemName:"trash")
                .foregroundColor(ColorManager.darkGreenHeader)}
                .padding()
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        let foodObject = FoodObject(Name:"Kiwis", Quantity: "A bunch", Starred: true)
        ItemRow(Food: foodObject, Category: "fridge")
    }
}
