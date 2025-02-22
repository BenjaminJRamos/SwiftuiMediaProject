//
//  ImageUploader.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/29/23.
//

import Foundation
import FirebaseStorage
import UIKit 
import SwiftUI
 

struct imageUploader {
       // UPLOAD MULTIPLE IMAGES
    static func UploadImages(image selections: [UIImage]) async throws -> [String]?  {
        var Strings = [String]()
        do {
            for selection in selections {
                if let imageData = selection.jpegData(compressionQuality: 0.5) {
                    let filename = NSUUID().uuidString
                    let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
                    
                    
                    let _ = try await ref.putDataAsync(imageData)
                    let url = try await ref.downloadURL()
                    Strings.append(url.absoluteString)
                }
            }
            return Strings
            
        } catch {
                        print ("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                        return nil
                }
            }
    
    // UPLOAD A SINGLE IMAGE 
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
       
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print ("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
 



    



 




