//
//  Logger.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

fileprivate enum LogType: String {
    case Verbose = "VERBOSE"
    case Debug = "DEBUG"
    case Info = "INFO"
    case Warning = "WARNING"
    case Error = "ERROR"
}

public struct Logger {

    private var canLocalLog: Bool
    private var canServerLog: Bool
    private let homeDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    init(canLocalLog: Bool = true, canServerLog: Bool = true) {
        self.canLocalLog = canLocalLog
        self.canServerLog = canServerLog
        info("Home Dir", context: homeDir.absoluteString)
    }

    func verbose(_ header: CustomStringConvertible, context: CustomStringConvertible? = nil, file: String = #file, function: String = #function) {
        log(type: .Verbose, header: header, context: context, file: file, function: function)
    }

    func debug(_ header: CustomStringConvertible, context: CustomStringConvertible? = nil, file: String = #file, function: String = #function) {
        log(type: .Debug, header: header, context: context, file: file, function: function)
    }

    func info(_ header: CustomStringConvertible, context: CustomStringConvertible? = nil, file: String = #file, function: String = #function) {
        log(type: .Info, header: header, context: context, file: file, function: function)
    }

    func warning(_ header: CustomStringConvertible, context: CustomStringConvertible? = nil, file: String = #file, function: String = #function) {
        log(type: .Warning, header: header, context: context, file: file, function: function)
    }

    func error(_ header: CustomStringConvertible, context: CustomStringConvertible? = nil, file: String = #file, function: String = #function) {
        log(type: .Error, header: header, context: context, file: file, function: function)
    }

    func removeOutdatedLogs() {
        removeLogs(daysBefore: 7)
    }

    func sendLogs() {
        guard Connectivity.isConnectedToInternet else {
            warning("Logger cannot send log", context: "Device is not connected to the Internet")
            return
        }

        removeOutdatedLogs()
        var logs: [URL] = []
        let enumerator = FileManager.default.enumerator(at: homeDir, includingPropertiesForKeys: nil)
        while let element = enumerator?.nextObject() as? URL {
            let filename = element.lastPathComponent
            if !filename.hasSuffix(".log") { continue }
            logs.append(element)
        }
        AlamofireService.shared.sendLogs(logs, completion: nil)
    }

}

extension Logger {

    private func log(type: LogType, header: CustomStringConvertible, context: CustomStringConvertible?, file: String, function: String) {
        if canLocalLog { enableLocalLogging(type, header, context, file, function) }
        if canServerLog { enableServerLogging(type, header, context, file, function) }
    }

    private func enableLocalLogging(_ type: LogType, _ header: CustomStringConvertible, _ context: CustomStringConvertible?, _ file: String, _ function: String) {
        let log = getLocalLog(type, header, context, file, function)
        print(log)
    }

    private func enableServerLogging(_ type: LogType, _ header: CustomStringConvertible, _ context: CustomStringConvertible?, _ file: String, _ function: String) {
        let log = getServerLog(type, header, context, file, function)
        toLogFile(log)
    }

}

extension Logger {

    private func toLogFile(_ string: String) {
        let string = string + "\n"
        let log = homeDir.appendingPathComponent("\(getFilename()).log")

        if let handle = try? FileHandle(forWritingTo: log) {
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? string.data(using: .utf8)?.write(to: log)
        }
    }

    private func removeLogs(daysBefore n: TimeInterval) {
        let enumerator = FileManager.default.enumerator(at: homeDir, includingPropertiesForKeys: nil)
        while let element = enumerator?.nextObject() as? URL {
            let filename = element.lastPathComponent
            if !filename.hasSuffix(".log") { continue }

            let saveUntil = "\(getFilename(daysBefore: n)).log"
            if filename < saveUntil {
                try? FileManager.default.removeItem(at: element)
            }
        }
    }

    private func getLocalLog(_ type: LogType, _ header: CustomStringConvertible, _ context: CustomStringConvertible?, _ file: String, _ function: String) -> String {
        let log = "\(getCurrentTime()) \(type.rawValue) | \(header)"
        return context == nil ? log : log + " | \(context!.description)"
    }

    private func getServerLog(_ type: LogType, _ header: CustomStringConvertible, _ context: CustomStringConvertible?, _ file: String, _ function: String) -> String {
        let log = "\(getCurrentTime(withDate: true)) \(file) \(function) \(type.rawValue) [\(header)]"
        return context == nil ? log : log + " \(context!.description)"
    }

    private func getCurrentTime(withDate: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withDate ? "yyyy-MM-dd HH:mm:ss XXX" : "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

    private func getFilename(daysBefore n: TimeInterval = 0) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: Date(timeInterval: -n * 86_400, since: Date()))
    }

}
