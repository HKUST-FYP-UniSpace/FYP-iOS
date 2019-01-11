//
//  DocumentHandler.swift
//  UniSpace
//
//  Created by KiKan Ng on 9/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class DocumentHandler: NSObject {

    static let shared = DocumentHandler()
    private let homeDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    func saveImageAsPNG(_ image: UIImage, filename: String) -> URL? {
        guard let data = image.pngData() else { return nil }
        let filename = homeDir.appendingPathComponent("\(filename).png")
        do {
            try data.write(to: filename)
            return filename
        } catch {
            return nil
        }
    }

    func saveImageAsJPEG(_ image: UIImage, filename: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        let filename = homeDir.appendingPathComponent("\(filename).jpeg")
        do {
            try data.write(to: filename)
            return filename
        } catch {
            return nil
        }
    }

    func createUrlForPDF(_ filename: String) -> URL {
        return homeDir.appendingPathComponent("\(filename).pdf")
    }

    func removeJpegs() {
        removeFiles(suffix: ".jpeg")
    }

    private func removeFiles(suffix: String) {
        let enumerator = FileManager.default.enumerator(at: homeDir, includingPropertiesForKeys: nil)
        while let element = enumerator?.nextObject() as? URL {
            let filename = element.lastPathComponent
            if !filename.hasSuffix(suffix) { continue }
            try? FileManager.default.removeItem(at: element)
        }
    }
}
