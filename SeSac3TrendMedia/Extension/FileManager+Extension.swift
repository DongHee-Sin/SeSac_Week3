//
//  FileManager+Extension.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/26.
//

import Foundation


extension FileManager {
    func sizeOfFile(atPath path: String) -> Int64? {
        guard let attrs = try? attributesOfItem(atPath: path) else {
            return nil
        }

        return attrs[.size] as? Int64
    }
}
