//
//  AddressView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: SharedOrder

        var body: some View {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zipcode", text: $order.zip)
                }

                Section {
                    NavigationLink {
                        CheckoutView(order: order)
                    } label: {
                        Text("Check out")
                    }
                }
                .disabled(order.hasValidAddress == false) // If any of the fields is empty, the check out link will be disabled
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        }
   }

   struct AddressView_Previews: PreviewProvider {
       static var previews: some View {
           AddressView(order: SharedOrder())
       }
   }
