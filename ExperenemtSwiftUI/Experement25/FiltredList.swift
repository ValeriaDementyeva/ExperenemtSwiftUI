//
//  FiltredList.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//
import CoreData
import SwiftUI

struct FiltredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    var content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}


//struct FiltredList: View {
//    @FetchRequest var fetchRequest: FetchedResults<Singer>
//
//    var body: some View {
//        List(fetchRequest, id: \.self) { singer in
//            Text("\(singer.wrappedFirstMane) \(singer.wrappedLastMane)")
//        }
//    }
//
//    init(filter: String) {
//        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
//}

