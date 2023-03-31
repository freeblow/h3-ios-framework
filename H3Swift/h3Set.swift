//
//  h3Set.swift
//  h3Swift
//
//  Created by 十亀眞怜 on 2018/07/27.
//  Copyright © 2018年 Pocket7878. All rights reserved.
//

import Foundation
import H3

public extension Array where Element == H3Index {
    public mutating func compact() throws -> Array<H3Index> {
        let sz: Int = self.count
        var out: Array<H3.H3Index> = Array<H3.H3Index>(repeating: 0, count: sz)
        var arr: Array<H3.H3Index> = self.map({ $0.index })
        let res = arr.withUnsafeMutableBufferPointer { (inputPtr) -> H3Error in
            return out.withUnsafeMutableBufferPointer({ (outPtr) -> H3Error in
                return H3.compactCells(inputPtr.baseAddress, outPtr.baseAddress, Int64(sz))
//                return H3.compact(inputPtr.baseAddress, outPtr.baseAddress, Int32(sz))
            })
        }
        guard res == 0 else {
            throw BadInputToCompact()
        }
        return out.filter({$0 != 0}).map({H3Index($0)})
    }
    
    public func uncompact(res: Int32) throws -> Array<H3Index> {
        let sz = maxUncompactSize(res: res)
        var out: Array<H3.H3Index> = Array<H3.H3Index>(repeating: 0, count: Int(sz))
        var arr: Array<H3.H3Index> = self.map({ $0.index })
        let res = arr.withUnsafeMutableBufferPointer { (inputPtr) -> H3Error in
            return out.withUnsafeMutableBufferPointer({ (outPtr) -> H3Error in
//                return H3.uncompact(inputPtr.baseAddress, Int32(self.count), outPtr.baseAddress, sz, res)
                return H3.uncompactCells(inputPtr.baseAddress, Int64(self.count), outPtr.baseAddress, Int64(sz), res)
            })
        }
        guard res == 0 else {
            throw BadInputToUncompact()
        }
        return out.filter({$0 != 0}).map({H3Index($0)})
    }
    
    func maxUncompactSize(res: Int32) -> Int32 {
        var arr : Array<H3.H3Index> = self.map({ $0.index })
        var ret : Int64 = 0
        arr.withUnsafeBufferPointer { (inPtr) -> Void in
            H3.uncompactCellsSize(inPtr.baseAddress, Int64(self.count), res, &ret)
//            return H3.maxUncompactSize(inPtr.baseAddress, Int32(self.count), res)
        }
        return Int32(ret)
    }
    
    mutating func toMultiplePolygon() -> Array<Array<Array<GeoCoord>>> {
        let out: UnsafeMutablePointer<LinkedGeoPolygon> = UnsafeMutablePointer.allocate(capacity: 1)
        let arr: Array<H3.H3Index> = self.map({ $0.index })
        arr.withUnsafeBufferPointer { (inPtr) -> Void in
            H3.cellsToLinkedMultiPolygon(inPtr.baseAddress, Int32(self.count), out)
        }
        var result: Array<Array<Array<GeoCoord>>> = Array<Array<Array<GeoCoord>>>()
        var currentPoly: LinkedGeoPolygon? = out.pointee
        while currentPoly != nil {
            var resultLoops: Array<Array<GeoCoord>> = Array<Array<GeoCoord>>()
            if currentPoly?.first != nil {
                var currentLoop: LinkedGeoLoop? = currentPoly?.first?.pointee
                guard let currLoop = currentLoop else {
                    break
                }
                var resultLoop: Array<GeoCoord> = Array<GeoCoord>()
                var coord: LinkedGeoCoord? = currLoop.first?.pointee
                while coord != nil {
                    let geoCoord = GeoCoord(lat: coord!.vertex.lat, lng: coord!.vertex.lng)
                    resultLoop.append(geoCoord)
                    coord = coord?.next?.pointee
                }
                resultLoops.append(resultLoop)
                currentLoop = currLoop.next?.pointee
            }
            result.append(resultLoops)
            currentPoly = currentPoly?.next?.pointee
        }
//        H3.destroyLinkedPolygon(out)
        H3.destroyLinkedMultiPolygon(out)
        return result
    }
}
