//
//  BundleExtension.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 08-09-24.
//

import Foundation

extension Bundle {
    
    public var appVersionShort: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "⚠️"
    }
    public var appVersionLong: String {
        return  infoDictionary?["CFBundleVersion"] as? String ?? "⚠️"
    }
    public var appName: String {
        return infoDictionary?["CFBundleName"] as? String ?? "⚠️"
    }
}
