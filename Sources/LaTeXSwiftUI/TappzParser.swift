//
//  File.swift
//  
//
//  Created by Sergey Rezanov on 28.11.2023.
//

import Foundation

class TappzParser {
    struct Block: Hashable {
        enum Style {
        case markdown
        case latex
        }
        
        let text: String
        let type: Style
    }
    
    static func parse(_ text: String) -> [Block]  {
        return text
            .split(separator: "\n\n")
            .map { String($0) }
            .map { Parser.parse($0).map { $0.replaceComponent() }.reduce("", +) }
            .map {
                Parser.parse($0)
                    .first(where: { $0.type.isEquation }) != nil
                ? Block(text: $0, type: .latex)
                : Block(text: $0, type: .markdown)
            }
    }
}

private extension Component {
    func replaceComponent() -> String {
        let line = originalText.replacingOccurrences(of: "\n", with: " ")
        let newComponents = Parser.parse(line)
        guard newComponents.first(where: { $0.type.isEquation }) != nil else { return originalText}
        var startIndex = originalText.startIndex
        var result = ""
        newComponents.forEach {
            if $0.type.isEquation {
                result += $0.originalText.replacingOccurrences(of: "\\ ", with: "\\\\ ")
                startIndex = originalText.index(startIndex, offsetBy: $0.originalText.count)
            } else {
                let endIndex = originalText.index(startIndex, offsetBy: $0.originalText.count)
                let text = originalText[startIndex ..< endIndex]
                startIndex = endIndex
                result += text
            }
        }
        return result
    }
}
