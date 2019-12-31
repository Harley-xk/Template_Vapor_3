//
//  Directory.swift
//  App
//
//  Created by Harley-xk on 2019/5/28.
//

import Foundation
import Vapor

final class Directory {
    
    static let current = Directory()
    
    enum Folder {
        case working
        case `public`
        case resources
        
        case images
        case pencils
        case pencilIcons
        case pencilTextures
        
        case receipts
        
        case chartlets
        case papers

        var path: URL {
            switch self {
            case .working: return Directory.current.working
            case .public: return Directory.current.public
            case .resources: return Directory.current.resources
            case .images: return Directory.current.images
            case .pencils: return Directory.current.pencils
            case .pencilIcons: return Directory.current.pencilIcons
            case .pencilTextures: return Directory.current.pencilTextures
            case .receipts: return Directory.current.receipts
            case .chartlets: return Directory.current.chartlets
            case .papers: return Directory.current.papers
            }
        }
    }
    
    private var working: URL
    private var `public`: URL
    private var resources: URL
    
    private  var images: URL
    private  var pencils: URL
    private  var pencilIcons: URL
    private  var pencilTextures: URL
    
    // 订阅凭据存放目录
    private var receipts: URL
    
    // 贴图c目录
    private var chartlets: URL
    
    // 纸张目录
    private var papers: URL
    
    init() {
        let workingPath = DirectoryConfig.detect().workDir
        working = URL(fileURLWithPath: workingPath)
        `public` = working.appendingPathComponent("Public", isDirectory: true)
        resources = working.appendingPathComponent("Resources", isDirectory: true)
        
        images = `public`.appendingPathComponent("images", isDirectory: true)
        pencils = images.appendingPathComponent("pencils", isDirectory: true)
        pencilIcons = pencils.appendingPathComponent("icons", isDirectory: true)
        pencilTextures = pencils.appendingPathComponent("textures", isDirectory: true)
        
        receipts = working.appendingPathComponent("Storage/receipts", isDirectory: true)
        try? FileManager.default.createDirectory(at: receipts, withIntermediateDirectories: true)
        
        chartlets = images.appendingPathComponent("chartlets", isDirectory: true)
        try? FileManager.default.createDirectory(at: chartlets, withIntermediateDirectories: true)
        
        papers = images.appendingPathComponent("papers", isDirectory: true)
        try? FileManager.default.createDirectory(at: papers, withIntermediateDirectories: true)
    }
    
    @discardableResult
    func save(data: Data, to folder: Folder, filename: String = UUID().uuidString) throws -> URL {
        let directory = folder.path
        if !FileManager.default.fileExists(atPath: directory.relativePath) {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        }
        let filePath = directory.appendingPathComponent(filename)
        try data.write(to: filePath)
        return filePath
    }
    
    func makeTemp() throws -> URL {
        let name = UUID().uuidString
        let temp = working.appendingPathComponent("Storage/temp/\(name)", isDirectory: true)
        try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true, attributes: nil)
        return temp
    }
}
