func parseMarkdown(_ markdown: String) -> String {
    var html = ""

    let lines = markdown.components(separatedBy: "\n")
    var inList = false

    for line in lines {
        if inList && !line.hasPrefix("- ") && !line.hasPrefix("* ") {
            html += "</ul>"
            inList = false
        }
        if line.hasPrefix("# ") {
            html += "<h1>"
            let lline = line.replacingOccurrences(of: "# ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h1>"
        } else if line.hasPrefix("## ") {
            html += "<h2>"
            let lline = line.replacingOccurrences(of: "## ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h2>"
        } else if line.hasPrefix("### ") {
            html += "<h3>"
            let lline = line.replacingOccurrences(of: "### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h3>"
        } else if line.hasPrefix("#### ") {
            html += "<h4>"
            let lline = line.replacingOccurrences(of: "#### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h4>"
        } else if line.hasPrefix("##### ") {
            html += "<h5>"
            let lline = line.replacingOccurrences(of: "##### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h5>"
        } else if line.hasPrefix("###### ") {
            html += "<h6>"
            let lline = line.replacingOccurrences(of: "###### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h6>"
        } else if line.hasPrefix("* ") {
            if !inList {
                html += "<ul>"
                inList = true
            }
            html += "<li>"
            let lline = line.replacingOccurrences(of: "* ", with: "")
            html += parseMarkdownLine(lline)
            html += "</li>"
        } else if line.hasPrefix("- ") {
            if !inList {
                html += "<ul>"
                inList = true
            }
            html += "<li>"
            let lline = line.replacingOccurrences(of: "- ", with: "")
            html += parseMarkdownLine(lline)
            html += "</li>"
        }
    }
    return html

}

func parseMarkdownLine(_ line: String) -> String {
    return line
}
