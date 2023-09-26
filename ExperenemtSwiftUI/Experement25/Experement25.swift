//
//  Experement25.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//

import SwiftUI
//58
struct Experement25: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var filterType = FilterType.beginsWith
    @State private var sortDescriptors = [SortDescriptor<Singer>]()

    var body: some View {
        VStack{
            FiltredList(filterKey: "lastName", filterValue: lastNameFilter, filterType: filterType, sortDescriptors: sortDescriptors) { (singer: Singer) in
                Text("\(singer.wrappedFirstMane) \(singer.wrappedLastMane)")
            }
            
            Button("Add Examples") {
                         let taylor = Singer(context: moc)
                         taylor.firstName = "Taylor"
                         taylor.lastName = "Swift"

                         let ed = Singer(context: moc)
                         ed.firstName = "Ed"
                         ed.lastName = "Sheeran"

                         let adele = Singer(context: moc)
                         adele.firstName = "Adele"
                         adele.lastName = "Adkins"

                         try? moc.save()

                     }

                     Button("Show A") {
                         lastNameFilter = "A"
                     }

                     Button("Show S") {
                         lastNameFilter = "S"
                     }

            Button("BEGINS WITH") {
                filterType = FilterType.beginsWith
            }

            Button("CONTAINS") {
                filterType = FilterType.contains
            }
            Button("Sort A-Z") {
                        sortDescriptors = [SortDescriptor(\.firstName)]
                    }

                    Button("Sort Z-A") {
                        sortDescriptors = [SortDescriptor(\.firstName, order: .reverse)]
                    }
            
        }
    }
}

struct Experement25_Previews: PreviewProvider {
    static var previews: some View {
        Experement25()
    }
}
