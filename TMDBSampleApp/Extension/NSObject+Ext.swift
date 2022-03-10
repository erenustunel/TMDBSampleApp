//
//  NSObject+Extension.swift
//  MovieApp
//
//  Created by Eren Üstünel on 10.12.2021.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
