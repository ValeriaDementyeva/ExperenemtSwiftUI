//
//  Experement17.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//

import SwiftUI

class User17: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    @Published var name = "Paul Hudson" // @Published announces changes to other views

    required init(from decoder: Decoder) throws { // The decoder contains all our data. We need to figure out how to read it, it's not a JSON decoder, it's a general decoder. We can read values from it. Required means that you must use it when creating a subclass of this class.
        let container = try decoder.container(keyedBy: CodingKeys.self) // We ask our decoder for a container that contains the keys to our CodingKeys enum. It will expect to find a name, because that is the only case in our enum.
        name = try container.decode(String.self, forKey: .name) // It will look for the key .name in the enum. If it finds it, it will be put into the property called name.
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name) // write our name to the key name. It sounds repetitive and it'll take some getting used to, but it works!
    }
}


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
struct Experement17: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            HStack{
                AsyncImage(url: URL(string: "https://www.hackingwithswift.com/samples/img/logo.png")) { phase in
                    if let image = phase.image { // if the image is succesfully loaded, then...
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil { // if there's an error, then...
                        Text("There was an error loading the image.")
                    } else { // if the image is still loading, then...
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)

                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
        }
        .task {
            await loadData() // await tells Swift that the function might "go to sleep", meaning it might take a while to complete
        }
    }

    func loadData() async { // async allows the function to wait until the necessary data from the internet is loaded until it's run. Meanwhile, other aspects of the app will still work. Users won't have to wait until it's completed.
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL") // The URL is defined in Apple's iTunes search API.
            return
        }

        do {
            let (data,_) = try await URLSession.shared.data(from: url) // The data from URL method contains a data instance of the data it found at the url. You must a try await as it may throw an error
            if let decodedResponse = try?  JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }


    }
}

struct Experement17_Previews: PreviewProvider {
    static var previews: some View {
        Experement17()
    }
}
