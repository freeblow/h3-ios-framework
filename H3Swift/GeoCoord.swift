//
//  GeoCoord.swift
//  h3Swift
//
//  Created by 十亀眞怜 on 2018/07/27.
//  Copyright © 2018年 Pocket7878. All rights reserved.
//

import Foundation
import H3

public extension GeoCoord {
    static func from(_ h3Index: H3Index) -> GeoCoord {
        var coord: GeoCoord = GeoCoord(lat: 0.0, lng: 0.0)
        withUnsafeMutablePointer(to: &coord) { (ptr) -> Void in
            cellToLatLng(h3Index.index, ptr)
        }
        return coord
    }
    
    mutating func toH3(res: Int32) -> H3Index {
        var ret : H3.H3Index = 0
        withUnsafeMutablePointer(to: &ret) { (ptr) -> Void in
            H3.latLngToCell(&self, res, ptr)
        }
        return H3Index(ret)
    }
}
