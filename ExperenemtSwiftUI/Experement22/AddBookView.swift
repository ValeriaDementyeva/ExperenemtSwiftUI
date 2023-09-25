//
//  AddBookView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
        @Environment(\.dismiss) var dismiss

        @State private var title = ""
        @State private var author = ""
        @State private var rating = 1
        @State private var genre = ""
        @State private var review = ""
    @FocusState private var amountIsFocused: Bool

        let genres = ["Select genre", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group{
                        TextField("Name of book", text: $title)
                        TextField("Name of author", text: $author)
                    } .focused($amountIsFocused)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                        .focused($amountIsFocused)

                    Picker("Rating", selection: $rating) {
                        ForEach(1..<6) {
                            Text(String($0))
                        }
                    }
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc) // create a new book in our managed object context

                        // Set the properties for the new book
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now

                        try? moc.save() // save the book to the managed object context
                        dismiss() // closes the viewe
                    }
                }
                .disabled(title.isEmptyReally || author.isEmptyReally || genre.isEmptyReally)
            }
            .navigationTitle("Add Book")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
