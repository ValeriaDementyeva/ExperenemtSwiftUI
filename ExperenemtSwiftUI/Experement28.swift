//
//  Experement28.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 27.09.2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct Experement28: View {
    @State private var image: Image?

    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    func loadImage() {
//        image = Image("Fantasy")
        guard let inputImage = UIImage(named: "Fantasy") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()

//        let currenfFilter = CIFilter.sepiaTone()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.intensity = 1

//        let currenfFilter = CIFilter.pixellate()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.scale = 60

//        let currenfFilter = CIFilter.crystallize()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.radius = 40

//        let currenfFilter = CIFilter.twirlDistortion()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.radius = 630
//        currenfFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)

//        let currenfFilter = CIFilter.motionBlur()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.radius = 12

//        let currenfFilter = CIFilter.colorInvert()
//        currenfFilter.inputImage = beginImage
//
//        let currenfFilter = CIFilter.comicEffect()
//        currenfFilter.inputImage = beginImage
//
//        let currenfFilter = CIFilter.pointillize()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.radius = 10

//        let currenfFilter = CIFilter.bloom()
//        currenfFilter.inputImage = beginImage
//        currenfFilter.intensity = 40

        let currenfFilter = CIFilter.edges()
        currenfFilter.inputImage = beginImage
        currenfFilter.intensity = 150



        guard let outputImage = currenfFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct Experement28_Previews: PreviewProvider {
    static var previews: some View {
        Experement28()
    }
}
