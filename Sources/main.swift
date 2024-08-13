// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

func readFile(_ path: String) -> String? {
    return try? String(contentsOfFile: path, encoding: .utf8)
}

func writeFile(_ content: String, path: String) {
    try? content.write(toFile: path, atomically: true, encoding: .utf8)
}

func main() {
    print("Give me the path to the markdown file")
    let path = readLine()!
    let markdown = readFile(path)
    if markdown == nil {
        print("file not found")
        return
    }
    print(markdown!)
    print("\n") 
    let html = parseMarkdown(markdown)
    path = path.replacingOccurrences(of: ".md", with: ".html")
    writeFile(html, path: path)
    print(html)
}

main()
