//
//  UIImageView+Extension.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/10/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
