//
//  Experement23.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//
import CoreData
import SwiftUI
//57
struct Experement23: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>
    var body: some View {
        VStack{
            List(movies, id: \.self) { movie in
                Text(movie.title ?? "Unknown")

            }
            Button("Add") {
                let movie = Movie(context: moc)
                movie.title = "Harry Potter"
            }

            Button("Save") {
                do {
                        try moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
//            Button("Save") {
//                    if moc.hasChanges {  // if there are changes in our moc, only then save.
//                        try? moc.save()
//                    }
//            }
        }
    }


struct Experement23_Previews: PreviewProvider {
    static var previews: some View {
        Experement23()
    }
}
