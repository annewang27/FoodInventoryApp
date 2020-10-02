//
//  FridgeView.swift
//  FoodInventoryApp
//
//  Created by Anne Wang on 2020-04-23.
//  Copyright © 2020 Anne Wang. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct CategoryView: View {
    let Category: String
    
    @State private var showFridge = false
//    @State private var toDelete = "" // ideally passed as a binding var to each row but it won't let me init
    @ObservedObject private var foodData = FoodList()
    
    init(category: String) {
        Category = category
        getData(category: Category)
    }
    
    func removeRows(at offsets: IndexSet) {
        offsets.sorted(by: > ).forEach { (i) in
            let name = foodData.objects[i].name
            print(name)
        }
        
        foodData.objects.remove(atOffsets: offsets)
    }
    
    var body: some View {
        ForEach(foodData.objects, id: \.name) { data in
            ItemRow(Food: data, Category: Category)
        }.onDelete(perform: removeRows)
        
        
        NavigationLink(destination: AddFoodView(Category: Category, Editing: false)) {
            Text("Add +")
                .foregroundColor(ColorManager.darkGreenHeader)
        }.buttonStyle(PlainButtonStyle())
    }
    
    private func getData(category: String) {
        let db = Firestore.firestore()
        self.foodData.objects = [FoodObject]()
        db.collection(category).getDocuments() { (querySnapshot, err) in
            if let err = err {
                    print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let newFood = FoodObject(Name: document.documentID , Quantity: document.get("quantity") as! String, Starred: Bool(document.get("starred") as! String)!)
                    self.foodData.objects.append(newFood)
                }
            }
        }
    }
}


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "Fridge")
    }
}
