//
//  GeneralView22.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI

struct GeneralView22: View {
    @Environment(\.managedObjectContext) var moc // moc to store view context for our data model which we can use to delete books
       @FetchRequest(sortDescriptors: [SortDescriptor(\.title), SortDescriptor(\.author)]) var books: FetchedResults<Book> // reads out all the books we've added so far, sorted by title

       @State private var showingAddScreen = false // Used to show a sheet where we add books

       var body: some View {
           NavigationView {
               List {
                   ForEach(books) { book in
                       NavigationLink {
                           DetailView(book: book)
                       } label: {
                           HStack {
                               EmojiRatingView(rating: book.rating)
                                   .font(.largeTitle)

                               VStack(alignment: .leading) {
                                   Text(book.title ?? "Unknown Title")
                                                  .font(.headline)
                                                  .foregroundColor(book.rating == 0 ? .red : .primary)

                                   Text(book.author ?? "Unknown Author")
                                       .foregroundColor(.secondary)
                               }
                           }
                       }
                   }
                   .onDelete(perform: deleteBooks)
               }
               .navigationTitle("Bookworm")
               .toolbar {
                   ToolbarItem(placement: .navigationBarLeading) {
                       EditButton()
                   }

                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button {
                           showingAddScreen.toggle()
                       } label: {
                           Label("Add Book", systemImage: "plus")
                       }
                   }
               }

               .sheet(isPresented: $showingAddScreen) {
                   AddBookView()
               }
           }
       }

       func deleteBooks(at offsets: IndexSet) {
           for offset in offsets { // Loop through all the offsets given
               let book = books[offset] // Find the book in the fetch request
               moc.delete(book) // book is now the object we want to delete, which we can then delete
           }

          // try? moc.save() // try saving the moc
       }
}

struct GeneralView22_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView22()
    }
}
