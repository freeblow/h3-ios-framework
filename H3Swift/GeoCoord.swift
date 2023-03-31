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
    public static func from(_ h3Index: H3Index) -> GeoCoord {
        var coord: GeoCoord = GeoCoord(lat: 0.0, lng: 0.0)
        withUnsafeMutablePointer(to: &coord) { (ptr) -> Void in
            cellToLatLng(h3Index.index, ptr)
        }
        return coord
    }
    
    public mutating func toH3(res: Int32) -> H3Index {
        return withUnsafePointer(to: &self) { (ptr) -> H3Index in
            H3.latLngToCell(<#T##g: UnsafePointer<LatLng>!##UnsafePointer<LatLng>!#>, <#T##res: Int32##Int32#>, <#T##out: UnsafeMutablePointer<H3Index>!##UnsafeMutablePointer<H3Index>!#>)
            return H3Index(H3.geoToH3(ptr, res))
        }
    }
}
