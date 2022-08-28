//
//  DocumentManager.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/28.
//

import UIKit


struct DocumentManager {
    
    private func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentDirectory
    }
    
    
    
    func createImageDirectory() {
        guard let path = documentDirectoryPath() else { return }

        let directoryPath = path.appendingPathComponent("image")

        if !FileManager.default.fileExists(atPath: directoryPath.path) {
            do {
                try FileManager.default.createDirectory(at: directoryPath, withIntermediateDirectories: true)
            }
            catch {
                print("Image 폴더 생성 실패")
            }
        }else {
            print("image directory 이미 있다!")
        }
    }
    
    
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = documentDirectoryPath() else { return }
        
        let imageDirectoryURL = documentDirectory.appendingPathComponent("image", isDirectory: true)
        let fileURL = imageDirectoryURL.appendingPathComponent("\(fileName).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        }catch let error {
            print(error)
        }
    }
    
    
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = documentDirectoryPath() else { return }
        
        let imageDirectoryURL = documentDirectory.appendingPathComponent("image", isDirectory: true)
        let fileURL = imageDirectoryURL.appendingPathComponent("\(fileName).jpg")
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        }catch let error {
            print(error)
        }
    }
    
    
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = documentDirectoryPath() else { return nil }
        
        let imageDocumentURL = documentDirectory.appendingPathComponent("image")
        let fileURL = imageDocumentURL.appendingPathComponent("\(fileName).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        }else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    
    
    func removeFileFromDocument(fileName: String) {
        guard let documentDirectory = documentDirectoryPath() else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        }
        catch let error {
            print(error)
        }
    }
    
    
    
    func fetchDocumentZipFile() -> [URL] {
        do {
            guard let path = documentDirectoryPath() else { return [] }
            
            // Document에 포함된 모든 파일의 URL을 가져온다.
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            // Document에 포함된 파일 중, 확장자(pathExtension)가 zip인 파일의 URL만 filter 한다.
            let zip = docs.filter { $0.pathExtension == "zip" }
            
            return zip
            
        }catch let error {
            print(error)
            return []
        }
        
    }
}
