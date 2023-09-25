//
//  CheckoutView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: SharedOrder

      @State private var confirmationMessage = ""
      @State private var showingConfirmation = false
      @State private var errorMessage = ""
      @State private var showingError = false

      var body: some View {
          ScrollView {
              VStack {
                  // Load an image from the internet
                  AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {  image in
                      image
                          .resizable()
                          .scaledToFit()
                  } placeholder: {
                      ProgressView()
                  }
                  .frame(height: 233)

                  Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                      .font(.title)

                  Button("Place Order") {
                      Task { // a button does not support an async function by default. A task + await resolves this
                          await placeOrder()
                      }
                  }
                      .padding()
              }
          }
          .navigationTitle("Checkout")
          .navigationBarTitleDisplayMode(.inline)
          .alert("Thank you!", isPresented: $showingConfirmation) {
              Button("OK") {}
          } message: {
              Text(confirmationMessage)
          }
          .alert("Oops", isPresented: $showingError) {
              Button("OK") {}
          } message: {
              Text(errorMessage)
          }
      }

      func placeOrder() async { // Just like when downloading, we need to use async when uploading
          guard let encoded = try? JSONEncoder().encode(order.data) else { // try to encode our order and if it fails for whatever reason, print and end the function
              print("Failed to encode order")
              return
          }

          let url = URL(string: "https://reqres.in/api/cupcakes")! // The exclamation mark is to indicate that we should not get back an optional in case the URL is wrong.
          var request = URLRequest(url: url)
          request.setValue("application/json", forHTTPHeaderField: "Content-Type") // we are writing JSON f
           request.httpMethod = "POST" // POST is for writing data to a server. GET is to read data.

          do {
              let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
              let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
              confirmationMessage = "Your order for \(decodedOrder.quantity) x \(SharedOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
              showingConfirmation = true
          } catch {
              errorMessage = "Sorry, checkout failed. \n\nMessage: \(error.localizedDescription)"
              showingError = true
          }
      }
   }

   struct CheckoutView_Previews: PreviewProvider {
       static var previews: some View {
           NavigationView {
               CheckoutView(order: SharedOrder())
           }
       }

}


