//
//  DetailView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI

struct DetailView: View {
    let book: Book

       @Environment(\.managedObjectContext) var moc
       @Environment(\.dismiss) var dismiss
       @State private var showingDeleteAlert = false

       var body: some View {
           ScrollView {
               ZStack(alignment: .bottomTrailing) {
                   Image(book.genre ?? "XXX")
                       .resizable()
                       .scaledToFit()

                   Text(book.genre?.uppercased() ?? "FANTASY")
                       .font(.caption)
                       .fontWeight(.black)
                       .padding(8)
                       .foregroundColor(.white)
                       .background(.black.opacity(0.75))
                       .clipShape(Capsule())
                       .offset(x: -5, y: -5)
               }

               Text(book.author ?? "Unknown Author")
                   .font(.title)
                   .foregroundColor(.secondary)

               if let date = book.date {
                   Text(date.formatted(date: .abbreviated, time: .omitted))
               }

               Text(book.review ?? "No review")
                   .padding()

               RatingView(rating: .constant(Int(book.rating + 1)))
                   .font(.largeTitle)

           }

           .navigationTitle(book.title ?? "Unknown Book")
           .navigationBarTitleDisplayMode(.inline)

           .alert("Delete Book", isPresented: $showingDeleteAlert) {
               Button("Delete", role: .destructive, action: deleteBook)
               Button("Cancel", role: .cancel) {}
           } message: {
               Text("Are you sure?")
           }
           .toolbar {
               Button {
                   showingDeleteAlert = true
               } label: {
                   Label("Delete this book", systemImage: "trash")
               }
           }
       }

       func deleteBook() {
           moc.delete(book)

           // try? moc.save()
           dismiss()
       }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(book: Book)
//    }
//}
