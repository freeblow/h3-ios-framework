//
//  Util.swift
//  h3Swift
//
//  Created by 十亀眞怜 on 2018/07/27.
//  Copyright © 2018年 Pocket7878. All rights reserved.
//

import Foundation
import H3

public func degsToRads(_ double: Double) -> Double {
    return H3.degsToRads(double)
}

public func radsToDegs(_ double: Double) -> Double {
    return H3.radsToDegs(double)
}

public enum DistanceUnit {
    case km
    case m
}

public func hexAreaKm2(_ res: Int32) -> Double{
    let areas : [Double] = [
        4250546.848, 607220.9782, 86745.85403, 12392.26486,
        1770.323552, 252.9033645, 36.1290521,  5.1612932,
        0.7373276,   0.1053325,   0.0150475,   0.0021496,
        0.0003071,   0.0000439,   0.0000063,   0.0000009];
    return areas[Int(res)]
}

public func hexAreaM2(_ res: Int32) -> Double{
    let areas : [Double] = [
        4.25055E+12, 6.07221E+11, 86745854035, 12392264862,
        1770323552,  252903364.5, 36129052.1,  5161293.2,
        737327.6,    105332.5,    15047.5,     2149.6,
        307.1,       43.9,        6.3,         0.9];
    return areas[Int(res)]
}

public func hexArea(res: Int32, unit: DistanceUnit) -> Double {
    switch(unit) {
    case .km:
        return hexAreaKm2(res)
    case .m:
        return hexAreaM2(res)
    }
}

public func edgeLengthKm(_ res: Int32) -> Double{
    let lens : [Double] = [
        1107.712591, 418.6760055, 158.2446558, 59.81085794,
        22.6063794,  8.544408276, 3.229482772, 1.220629759,
        0.461354684, 0.174375668, 0.065907807, 0.024910561,
        0.009415526, 0.003559893, 0.001348575, 0.000509713];
    return lens[Int(res)]
}

public func edgeLengthM(_ res: Int32) -> Double{
    let lens : [Double] = [
        1107712.591, 418676.0055, 158244.6558, 59810.85794,
        22606.3794,  8544.408276, 3229.482772, 1220.629759,
        461.3546837, 174.3756681, 65.90780749, 24.9105614,
        9.415526211, 3.559893033, 1.348574562, 0.509713273];
    return lens[Int(res)]
}

public func edgeLength(res: Int32, unit: DistanceUnit) -> Double {
    switch(unit) {
    case .km:
        return edgeLengthKm(res)
    case .m:
        return edgeLengthM(res)
    }
}

public func numHexagons(res: Int32) -> Int64 {
    let  nums : [Int64] = [ 122,
                            842,
                            5882,
                            41162,
                            288122,
                            2016842,
                            14117882,
                            98825162,
                            691776122,
                            4842432842,
                            33897029882,
                            237279209162,
                            1660954464122,
                            11626681248842,
                            81386768741882,
                            569707381193162];
    return nums[Int(res)];
}
