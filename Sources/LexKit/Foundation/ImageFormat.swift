//
//  ImageFormat.swift
//  
//
//  Created by Lex on 6/17/24.
//

import Foundation

public enum ImageFormat {
    /// The format cannot be recognized or not supported yet.
    case unknown
    /// PNG image format.
    case PNG
    /// JPEG image format.
    case JPEG
    /// GIF image format.
    case GIF
    
    case TIFF
    
    public struct HeaderData {
        public static var PNG: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
        public static var JPEG_SOI: [UInt8] = [0xFF, 0xD8]
        public static var JPEG_IF: [UInt8] = [0xFF]
        public static var GIF: [UInt8] = [0x47, 0x49, 0x46]
        
        public static var TIFF_A: [UInt8] = [0x42, 0x49, 0x4D, 0x00]
        public static var TIFF_B: [UInt8] = [0x49, 0x49, 0x2A, 0x00]
        public static var TIFF_C: [UInt8] = [0x4D, 0x4D, 0x00, 0x2A]
    }
    
    /// https://en.wikipedia.org/wiki/JPEG
    public enum JPEGMarker {
        case SOF0           //baseline
        case SOF2           //progressive
        case DHT            //Huffman Table
        case DQT            //Quantization Table
        case DRI            //Restart Interval
        case SOS            //Start Of Scan
        case RSTn(UInt8)    //Restart
        case APPn           //Application-specific
        case COM            //Comment
        case EOI            //End Of Image
        
        public var bytes: [UInt8] {
            switch self {
            case .SOF0:         return [0xFF, 0xC0]
            case .SOF2:         return [0xFF, 0xC2]
            case .DHT:          return [0xFF, 0xC4]
            case .DQT:          return [0xFF, 0xDB]
            case .DRI:          return [0xFF, 0xDD]
            case .SOS:          return [0xFF, 0xDA]
            case .RSTn(let n):  return [0xFF, 0xD0 + n]
            case .APPn:         return [0xFF, 0xE0]
            case .COM:          return [0xFF, 0xFE]
            case .EOI:          return [0xFF, 0xD9]
            }
        }
    }
}
