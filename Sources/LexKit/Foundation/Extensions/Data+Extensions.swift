//
//  Data+Extensions.swift
//  
//
//  Created by Lex on 6/17/24.
//

import Foundation
import ImageIO


public extension Data {
    
    /// Gets the image format corresponding to the data.
    var imageFormat: ImageFormat {
        guard self.count > 8 else { return .unknown }
        
        var buffer = [UInt8](repeating: 0, count: 8)
        self.copyBytes(to: &buffer, count: 8)
        
        if buffer == ImageFormat.HeaderData.PNG {
            return .PNG
            
        } else if buffer[0] == ImageFormat.HeaderData.JPEG_SOI[0],
            buffer[1] == ImageFormat.HeaderData.JPEG_SOI[1],
            buffer[2] == ImageFormat.HeaderData.JPEG_IF[0]
        {
            return .JPEG
            
        } else if buffer[0] == ImageFormat.HeaderData.GIF[0],
            buffer[1] == ImageFormat.HeaderData.GIF[1],
            buffer[2] == ImageFormat.HeaderData.GIF[2]
        {
            return .GIF
            
        } else if buffer[0] == ImageFormat.HeaderData.TIFF_A[0],
                  buffer[1] == ImageFormat.HeaderData.TIFF_A[1],
                  buffer[2] == ImageFormat.HeaderData.TIFF_A[2] {
            
            return .TIFF
            
        } else if buffer[0] == ImageFormat.HeaderData.TIFF_B[0],
                 buffer[1] == ImageFormat.HeaderData.TIFF_B[1],
                 buffer[2] == ImageFormat.HeaderData.TIFF_B[2] {
           
           return .TIFF
           
       } else if buffer[0] == ImageFormat.HeaderData.TIFF_C[0],
                 buffer[1] == ImageFormat.HeaderData.TIFF_C[1],
                 buffer[2] == ImageFormat.HeaderData.TIFF_C[2] {
           
           return .TIFF
           
       }
        
        return .unknown
    }
    
    func contains(jpeg marker: ImageFormat.JPEGMarker) -> Bool {
        guard imageFormat == .JPEG else {
            return false
        }
        
        let bytes = [UInt8](self)
        let markerBytes = marker.bytes
        for (index, item) in bytes.enumerated() where bytes.count > index + 1 {
            guard
                item == markerBytes.first,
                bytes[index + 1] == markerBytes[1] else {
                continue
            }
            return true
        }
        return false
    }
}
