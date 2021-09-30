//
//  ImageService.swift
//  rappypaytest
//
//  Created by Enar GoMez on 26/09/21.
//

import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageService {

    var imageCache = _imageCache

    func loadImage(with url: URL, onComplete: @escaping (_ success:Bool, _ image:UIImage)->()) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            onComplete(true, imageFromCache)
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [] in
                    onComplete(true, image)
                }
            } catch {
                onComplete(false, UIImage())
                print(error.localizedDescription)
            }
        }
    }
}
