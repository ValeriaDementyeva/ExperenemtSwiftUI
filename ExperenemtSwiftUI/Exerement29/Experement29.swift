//
//  Experement29.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 27.09.2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct Experement29: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.0

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var showingFilterSheet = false

    enum FilterType: String {
        case crystallize = "Crystallize"
        case pointillize = "Pointillize"
        case gaussianBlur = "Gaussian Blur"
        case pixellate = "Pixellate"
        case sepiaTone = "Sepia Tone"
        case unsharpMask = "Unsharp Mask"
        case vignette = "Vignette"

        case cancel = "Cancel"
    }


    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(.secondary.opacity(0.6))

                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)

                image?
                    .resizable()
                    .scaledToFit()

            }
            .onTapGesture {
                showingImagePicker = true
            }

                if image != nil {
                    HStack{
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { newValue in
                                applyProcessing()
                            }
                    }  .padding(.vertical)



            HStack{
                Button("Change Filter") {
                    showingFilterSheet = true
                }
                Spacer()

                    Button("Save", action: save)
                }
            }
        }
        .padding(10)
        .navigationTitle("Instafilter")
        .onChange(of: inputImage) { _ in
            loadeImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
            Button(FilterType.crystallize.rawValue) {
                setFilter(CIFilter.crystallize())
            }
            Button(FilterType.pointillize.rawValue) {
                setFilter(CIFilter.pointillize())
            }
            Button(FilterType.gaussianBlur.rawValue) {
                setFilter(CIFilter.gaussianBlur())
            }
            Button(FilterType.pixellate.rawValue) {
                setFilter(CIFilter.pixellate())
            }
            Button(FilterType.sepiaTone.rawValue) {
                setFilter(CIFilter.sepiaTone())
            }
            Button(FilterType.unsharpMask.rawValue) {
                setFilter(CIFilter.unsharpMask())
            }
            Button(FilterType.vignette.rawValue) {
                setFilter(CIFilter.vignette())
            }

            Button(FilterType.cancel.rawValue, role: .cancel) {}
        }

    }
    func loadeImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 150, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 100, forKey: kCIInputScaleKey)
        }


        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadeImage()
    }
}

struct Experement29_Previews: PreviewProvider {
    static var previews: some View {
        Experement29()
    }
}
