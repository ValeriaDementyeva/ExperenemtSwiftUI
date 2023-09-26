//
//  FiltredList.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//
import CoreData
import SwiftUI

enum FilterType: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS[c]"
}

struct FiltredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    var content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, filterType: FilterType, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filterType.rawValue) %@", filterKey, filterValue))
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

