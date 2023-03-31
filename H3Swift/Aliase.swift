//
//  Aliase.swift
//  h3Swift
//
//  Created by 十亀眞怜 on 2018/07/27.
//  Copyright © 2018年 Pocket7878. All rights reserved.
//

import Foundation
import H3

public let MAX_CELL_BNDRY_VERTS = 10
public typealias GeoCoord = H3.LatLng
public typealias GeoBoundary = H3.CellBoundary
public typealias Geofence = H3.GeoLoop
public typealias GeoPolygon = H3.GeoPolygon
public typealias GeoMultiPolygon = H3.GeoMultiPolygon
public typealias LinkedGeoCoord = H3.LinkedLatLng
public typealias LinkedGeoPolygon = H3.LinkedGeoPolygon

public extension GeoCoord {
    static var zero: GeoCoord {
        return GeoCoord(lat: 0, lng: 0)
    }
}

public extension GeoBoundary {
    public static var zero: GeoBoundary {
        return GeoBoundary(numVerts: 0, verts: (
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero,
            GeoCoord.zero
        ))
    }
}

public extension Geofence {
    init(coords: inout [GeoCoord]) {
        self.init(numVerts: Int32(coords.count), verts: &coords)
    }
}

public extension GeoPolygon {
    init(coords: inout [GeoCoord]) {
        let fence = Geofence(coords: &coords)
        var emptyArray: [Geofence] = []
        self.init(geoloop: fence, numHoles: 0, holes: &emptyArray)
    }
    
    init(coords: inout [GeoCoord], holes: inout [Geofence]) {
        let edge = Geofence(coords: &coords)
        self.init(geoloop: edge, numHoles: Int32(holes.count), holes: &holes)
    }
}
