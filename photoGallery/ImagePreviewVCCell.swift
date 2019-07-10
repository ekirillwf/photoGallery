//
//  ImagePreviewVCCell.swift
//  photoGallery
//
//  Created by Кирилл Елсуфьев on 10/07/2019.
//  Copyright © 2019 Кирилл Елсуфьев. All rights reserved.
//

import UIKit

class ImagePreviewVCCell: UICollectionViewCell, UIScrollViewDelegate{
  
    @IBOutlet var scrollImg: UIScrollView!
    @IBOutlet var image: UIImageView!
   
    override init(frame: CGRect) {
        super.init(frame: frame)

        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2

    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = image.frame.size.height / scale
        zoomRect.size.width  = image.frame.size.width  / scale
        let newCenter = image.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.image
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        scrollImg.frame = self.bounds
//        image.frame = self.bounds
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

