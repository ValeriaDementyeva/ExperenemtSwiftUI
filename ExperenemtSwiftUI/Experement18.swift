//
//  Experement18.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//

import SwiftUI

struct Experement18: View {
    @State private var username =  ""
      @State private var email = ""

      var body: some View {
          VStack {
              Form {
                  Section {
                      TextField("Username", text: $username)
                      TextField("Email", text: $email)
                  }

                  Section {
                      Button("Create account") {
                          print("Creating account...")
                      }
                  }
                  .disabled(disabledForm)
              }
          }
      }
      var disabledForm: Bool {
          username.count < 5 || email.count < 5
    }
}

struct Experement18_Previews: PreviewProvider {
    static var previews: some View {
        Experement18()
    }
}
