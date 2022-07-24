//
//  Extensions.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(for url: String) {
        DispatchQueue.global(qos: .default).async {
            if let url = URL(string: url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
}
