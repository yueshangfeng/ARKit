//
//  ViewController.swift
//  TrackObject
//
//  Created by zyl on 2017/9/16.
//  Copyright © 2017年 zyl. All rights reserved.
//

import UIKit
import Vision
import ARKit
import CoreML

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加图片
        let zylImage = UIImage.init(named: "zllt.png")
        let imgSize = zylImage?.size
        let zylImageView = UIImageView.init(image: zylImage)
        
        zylImageView.frame.origin = CGPoint.init(x: 0, y: 0)
        zylImageView.frame.size = CGSize.init(width: view.frame.width, height: view.frame.size.width * (imgSize?.height)! / (imgSize?.width)!)
        
        view.addSubview(zylImageView)
        
        
        let detectedObj = VNDetectedObjectObservation.init()
        
        //创建请求
        let detectionRequest = VNTrackObjectRequest.init(detectedObjectObservation: detectedObj) { (request, err) in
            
            
        }
        
        //创建请求处理
        let requestHandler = VNSequenceRequestHandler.init()
        
        //开始追踪
        let observations = detectionRequest.results as! [VNDetectedObjectObservation]
        let objectsToTrack = observations.map {VNTrackObjectRequest(detectedObjectObservation: $0)}
        
        //执行请求
        let image = CIImage.init(image: zylImage!)
        try! requestHandler.perform(objectsToTrack, on: image!)
        
        for request in objectsToTrack {
            for observation in request.results as! [VNDetectedObjectObservation] {
                print(observation)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

