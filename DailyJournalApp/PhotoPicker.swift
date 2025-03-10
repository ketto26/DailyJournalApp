//
//  PhotoPicker.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 19.02.25.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @Binding var selectedImages: [UIImage]
    var sourceType: UIImagePickerController.SourceType
    
    var body: some View {
        PHPickerViewControllerRepresentable(selectedImages: $selectedImages)
    }
}

struct PHPickerViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImages: $selectedImages)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0 // Unlimited selection
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var selectedImages: [UIImage]
        
        init(selectedImages: Binding<[UIImage]>) {
            _selectedImages = selectedImages
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}
