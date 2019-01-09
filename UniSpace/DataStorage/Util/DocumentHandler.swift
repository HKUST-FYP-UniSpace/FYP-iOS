//
//  DocumentHandler.swift
//  UniSpace
//
//  Created by KiKan Ng on 9/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class DocumentHandler: NSObject{

    static let shared = DocumentHandler()

    func saveImageAsPNG(_ image: UIImage, filename: String) -> URL? {
        guard let data = image.pngData() else { return nil }
        let filename = getDocumentsDirectory().appendingPathComponent("\(filename).png")
        do {
            try data.write(to: filename)
            return filename
        } catch {
            return nil
        }
    }

    func saveImageAsJPEG(_ image: UIImage, filename: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        let filename = getDocumentsDirectory().appendingPathComponent("\(filename).jpeg")
        do {
            try data.write(to: filename)
            return filename
        } catch {
            return nil
        }
    }

    func createUrlForPDF(_ filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent("\(filename).pdf")
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
