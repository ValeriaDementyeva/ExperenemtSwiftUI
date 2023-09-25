//
//  GeneralView19.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//

import SwiftUI

struct GeneralView19: View {
    @StateObject var order = SharedOrder() // This order we create here will be shared among all other views in the app.

       var body: some View {
           NavigationView {
               Form {
                   Section {
                       Picker("Select your cake type", selection: $order.type) {
                           ForEach(SharedOrder.types.indices) { // Has the user requested extra frosting? False by default.
                               Text(SharedOrder.types[$0])
                           }
                       }

                       Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                   }

                   Section {
                       Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation()) // A toggle to enable special requests

                       if order.specialRequestEnabled { // If special requests are toggled on (if true), then...
                           Toggle("Add extra frosting", isOn: $order.extraFrosting) // Shows a toggle for extraFrosting
                           Toggle("Add extra sprinkles", isOn: $order.addSprinkles) // Shows a toggle for addSprinkles
                       }
                   }
                   Section {
                       NavigationLink {
                           AddressView(order: order) // Navigation links to our AddressView, passing in the order we've created
                       } label: {
                           Text("Delivery details")
                       }
                   }
               }
               .navigationTitle("Cupcake Corner") // Title
           }
    }
}

struct GeneralView19_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView19()
    }
}
